extends Control

@onready var timer := $dialogue_timer as Timer
@onready var name_lbl = $Panel/name
@onready var text_lbl = $Panel/text

var key = Data.cutscene_key
var scene_img = Data.cutscene_data[key][0]
var dialogue = Data.cutscene_data[key].slice(1, -1)

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().dial_ready and ready
	
	name_lbl.text = ""
	text_lbl.text = ""
	
	for line in dialogue:
		#print("hello")
		name_lbl.text = line[0]
		await load_text(line)
		# TODO: show next_img when line finished
		# TODO: click proceeds dialogue (needs fixing, use signals & input function in _process)
		await Input.is_action_just_pressed("")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# text animation
func load_text(line):
	#print("gogogo")
	for i in range(len(line[1])):
		text_lbl.text = line[1].substr(0, i+1)
		await get_tree().create_timer(0.1).timeout


func _on_dialogue_timer_timeout():
	pass # Replace with function body.
