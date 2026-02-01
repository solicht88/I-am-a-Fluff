extends Control

@onready var timer := $dialogue_timer as Timer
@onready var name_lbl = $Panel/name
@onready var text_lbl = $Panel/text

var key = Data.cutscene_key
var scene_img = Data.cutscene_data[key][0]
var dialogue = Data.cutscene_data[key].slice(1)

signal cont_dial

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().dial_ready
	$AnimationPlayer.play("open")
	
	name_lbl.text = ""
	text_lbl.text = ""
	
	for line in dialogue:
		#print("hello")
		name_lbl.text = line[0]
		await load_text(line)
		# TODO: show "next_img" when line finished
		await cont_dial
	
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	visible = false
	
	await get_tree().create_timer(1).timeout
	get_parent().dial_finished.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# click proceeds dialogue
func _input(event):
	if event.is_action_pressed("leftclick"):
		cont_dial.emit()


# text animation
func load_text(line):
	#print("gogogo")
	for i in range(len(line[1])):
		text_lbl.text = line[1].substr(0, i+1)
		timer.start()
		await timer.timeout
		#await get_tree().create_timer(0.08).timeout
		


func _on_dialogue_timer_timeout():
	pass # Replace with function body.
