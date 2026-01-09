extends Node2D

var scene_data = Data.cutscene_data[Data.cutscene_key]
var scene_img = scene_data[0]
# TODO: take all items but first
var dialogue = scene_data

signal dial_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	# show dialogue box after showing cutscene for a few seconds
	await get_tree().create_timer(2).timeout
	$dialogue_box.visible = true
	dial_ready.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
