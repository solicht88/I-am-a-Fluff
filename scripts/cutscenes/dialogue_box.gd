extends Control

@onready var timer := $dialogue_timer as Timer
@onready var name_lbl = $Panel/name
@onready var text_lbl = $Panel/text

var key = Data.cutscene_key
#var dialogue = Data.cutscene_data[key].slice(1)
var save_data = Save.save_data
var inv = save_data.inventory
var playing_dial = false;
var skip_dial = false;

signal cont_dial
signal change_img(img)

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().dial_ready
	#print("dial ready!")
	$choice.visible = false
	$AnimationPlayer.play("open")
	
	# ready does initial cutscene 
	# + connect dialogue to parent dial_ready signal for endings
	name_lbl.text = ""
	text_lbl.text = ""
	get_parent().dial_ready.connect(_start_dial)
	
	await _play_dial(Data.cutscene_data[key].slice(1))
	
	# changing above to match 
	match key:
		"end_0":
			# spaghetti code line right here
			if inv.dust and inv.ribbon and inv.lotus and inv.candle and inv.photo:
				_update_data("choice")
			else:
				_update_data("end_1")
		"end_1":
			_update_data("end_finale")
		"choice":
			# implements choice endings
			# connects _update_data to selected choice
			$choice.chosen_choice.connect(_update_data)
			$choice.color.a = 0
			$choice.visible = true
			$choice/AnimationPlayer.play("fade_in")
			await get_tree().create_timer(0.5).timeout
			
			# fade out after picking a choice
			await $choice.chosen_choice
			await get_tree().create_timer(0.5).timeout
		"choice_1":
			_update_data("choice_1_finale")
		"choice_2":
			_update_data("choice_2_finale")
		"end_finale", "choice_1_finale", "choice_2_finale":
			# at end of ending
			get_parent().the_end = true
		_:
			# if not at ending then finish cutscene as normal
			pass
	
	# close dialogue box n return to cutscene node
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	visible = false
	
	await get_tree().create_timer(1).timeout
	
	# this must be last, ends cutscene dialogue
	get_parent().dial_finished.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# click proceeds dialogue
func _input(event):
	if event.is_action_released("leftclick"):
		cont_dial.emit()
		if playing_dial:
			skip_dial = true


# text animation
func _load_text(line):
	for i in range(len(line[1])):
		if skip_dial:
			skip_dial = false
			text_lbl.text = line[1]
			break
		else:
			text_lbl.text = line[1].substr(0, i+1)
			timer.start()
			await timer.timeout
			#await get_tree().create_timer(0.08).timeout


# TODO: starts new dialogue (mostly useful for endings) 
func _start_dial():
	$choice.visible = false
	$AnimationPlayer.play("open")
	name_lbl.text = ""
	text_lbl.text = ""
	
	await _play_dial(Data.cutscene_data[key].slice(1))
	
	# ending logic here
	match key:
		"end_0":
			# spaghetti code line right here
			if inv.dust and inv.ribbon and inv.lotus and inv.candle and inv.photo:
				_update_data("choice")
			else:
				_update_data("end_1")
		"end_1":
			_update_data("end_finale")
		"choice":
			# implements choice endings
			# connects _update_data to selected choice
			$choice.chosen_choice.connect(_update_data)
			$choice.visible = true
			$choice/AnimationPlayer.play("fade_in")
			await get_tree().create_timer(0.5).timeout
			
			# fade out after picking a choice
			await $choice.chosen_choice
			$choice/AnimationPlayer.play("fade_out")
			await get_tree().create_timer(0.5).timeout
			$choice.visible = false
		"choice_1":
			_update_data("choice_1_finale")
		"choice_2":
			_update_data("choice_2_finale")
		"end_finale", "choice_1_finale", "choice_2_finale":
			# at end of ending
			get_parent().the_end = true
		_:
			# if not at ending then finish cutscene as normal
			pass
	
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	visible = false
	
	await get_tree().create_timer(1).timeout
	
	get_parent().dial_finished.emit()


func _play_dial(dialogue):
	for line in dialogue:
		name_lbl.text = line[0]
		playing_dial = true
		await _load_text(line)
		
		playing_dial = false
		# TODO: show "next_img" in dialogue box when line finished (might not do this)
		await cont_dial
		# prevents accidentally skipping next dialogue
		await get_tree().create_timer(0.05).timeout


func _update_data(new_key):
	Data.cutscene_key = new_key
	key = new_key


func _on_dialogue_timer_timeout():
	pass # Replace with function body.
