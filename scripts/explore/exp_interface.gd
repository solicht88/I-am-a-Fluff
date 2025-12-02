extends Control

@onready var fuel_icons = [$fuel_1, $fuel_2, $fuel_3]
@onready var jelly_icons = [$jelly_1, $jelly_2]

var save_data = Save.save_data

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	var inv = save_data.inventory
	for i in range(inv["fuel"]):
		fuel_icons[i].visible = true
	for i in range(inv["compass"]):
		$compass_img.visible = true
	for i in range(inv["jelly"]):
		jelly_icons[i].visible = true
		
	# TODO: update text to match inv

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
