extends Node2D

var scene_data = Data.cutscene_data[Data.cutscene_key]
var scene_img = scene_data[0]
# TODO: take all items but first
var dialogue = scene_data

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
