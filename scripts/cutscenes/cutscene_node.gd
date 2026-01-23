extends Node2D

var scene_data = Data.cutscene_data[Data.cutscene_key]
var scene_img = scene_data[0]
# TODO: take all items but first
var dialogue = scene_data

signal dial_ready
signal dial_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	dial_finished.connect(_end_scene)
	
	# show dialogue box after showing cutscene for a few seconds
	await get_tree().create_timer(1).timeout
	$dialogue_box.visible = true
	dial_ready.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _end_scene():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
