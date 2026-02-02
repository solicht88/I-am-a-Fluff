extends Control

@onready var timer := $dialogue_timer as Timer
@onready var name_lbl = $Panel/name
@onready var text_lbl = $Panel/text

var key = Data.cutscene_key
var scene_img = Data.cutscene_data[key][0]
var dialogue = Data.cutscene_data[key].slice(1)
var save_data = Save.save_data
var inv = save_data.inventory

signal cont_dial
signal change_img(img)

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().dial_ready
	$AnimationPlayer.play("open")
	
	name_lbl.text = ""
	text_lbl.text = ""
	
	'''
	for line in dialogue:
		#print("hello")
		name_lbl.text = line[0]
		await _load_text(line)
		# TODO: show "next_img" when line finished
		await cont_dial
	'''
	# TODO: fix whateveres causing the dialogue to skip
	# TODO: move dialogue code to a function so it can be replayed
	await _play_dial(dialogue)
	
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	visible = false
	
	await get_tree().create_timer(1).timeout
	
	# TODO: add ending scene code? will prob move this to cutscene_node
	if key == "end_0":
		if inv.dust and inv.ribbon and inv.lotus and inv.candle and inv.photo:
			pass
		else:
			_play_dial(Data.cutscene_data["end_1"].slice(1))
	
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
	#print("gogogo")
	for i in range(len(line[1])):
		text_lbl.text = line[1].substr(0, i+1)
		timer.start()
		await timer.timeout
		#await get_tree().create_timer(0.08).timeout


func _play_dial(dialogue):
	for line in dialogue:
		name_lbl.text = line[0]
		await _load_text(line)
		# TODO: show "next_img" when line finished
		await cont_dial


func _on_dialogue_timer_timeout():
	pass # Replace with function body.
