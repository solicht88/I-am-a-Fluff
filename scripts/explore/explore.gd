extends Node2D

@onready var bg_sprite = $bg

var save_data = Save.save_data

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	bg_sprite.texture = Data.exp_bgs[save_data.exp_lvl]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
