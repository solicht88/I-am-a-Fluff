extends Control

@onready var timer := $dialogue_timer as Timer
@onready var name_lbl = $Panel/name
@onready var text_lbl = $Panel/text

var key = Data.cutscene_key
#var dialogue = Data.cutscene_data[key].slice(1)
var save_data = Save.save_data
var inv = save_data.inventory

signal cont_dial
signal change_img(img)

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: change this to connect dialogue function w/ dial_ready signal
	# then wait for dialogue finished signal to close
	await get_parent().dial_ready
	$choice.visible = false
	$AnimationPlayer.play("open")
	
	# TODO: move this into start_dial, await start_dial instead?
	# OR: connect dialogue to parent dial_ready signal
	name_lbl.text = ""
	text_lbl.text = ""
	
	await _play_dial(Data.cutscene_data[key].slice(1))
	
	# maybe move this after key checking?
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	visible = false
	
	await get_tree().create_timer(1).timeout
	
	# TODO: change key based on ending, play dialgoue on _play_s cene() in parent
	# TODO: update this using _update_data if i don't move it
	'''oh goodness this needs to be cleaned up
	if key == "end_0":
		if inv.dust and inv.ribbon and inv.lotus and inv.candle and inv.photo:
			pass
		else:
			Data.cutscene_key = "end_1"
	
	elif key == "end_1":
		Data.cutscene_key = "end_finale"
	elif key == "choice_1":
		Data.cutscene_key = "choice_1_finale"
	elif key == "choice_2":
		Data.cutscene_key = "choice_2_finale"
	'''
	
	# changing above to match 
	match key:
		"end_1":
			pass
		"choice":
			# TODO: implement choice endings
			# connects _update_data to selected choice
			$choice.chosen_choice.connect(_update_data)
			$choice.color.a = 0
			$choice.visible = true
			$choice/AnimationPlayer.play("fade_in")
			await get_tree().create_timer(0.5).timeout
			
			# fade out after picking a choice
			await $choice.chosen_choice
			$choice/AnimationPlayer.play("fade_out")
			await get_tree().create_timer(0.5).timeout
			$choice.visible = false
		_:
			# check if at ending
			if key == "end_0":
				var extend_end = true
				
				var i = 0 
				for mem_key in inv:
					if !inv[mem_key] and i > 4:
						_update_data("end_1")
						extend_end = false
						break
					i += 1
				
				if extend_end:
					_update_data("choice")
			# continue ending if needed
			else:
				pass
	
	# this must be last
	get_parent().dial_finished.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# click proceeds dialogue
func _input(event):
	if event.is_action_pressed("leftclick"):
		cont_dial.emit()


# text animation
func _load_text(line):
	for i in range(len(line[1])):
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


func _play_dial(dialogue):
	for line in dialogue:
		name_lbl.text = line[0]
		await _load_text(line)
		# TODO: show "next_img" in dialogue box when line finished (might not do this)
		await cont_dial
	# TODO: add signal for end of dialogue (might not need?)
	# only add if doesn't wait for _start_dial()


func _update_data(new_key):
	Data.cutscene_key = new_key
	key = new_key


func _on_dialogue_timer_timeout():
	pass # Replace with function body.
