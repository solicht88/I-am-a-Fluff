extends Control

@onready var fuel_icons = [$fuel_1, $fuel_2, $fuel_3]
@onready var jelly_icons = [$jelly_1, $jelly_2]

var inv = Save.save_data.inventory

var popup = preload("res://scenes/explore/exp_popup.tscn")

var exp_btn_pos = [Vector2(685, 210), Vector2(724, 195), Vector2(1038, 330), Vector2(1038, 330)][Save.save_data.exp_lvl]

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	for i in range(inv["fuel"]):
		fuel_icons[i].visible = true
	for i in range(inv["compass"]):
		$compass_img.visible = true
	for i in range(inv["jelly"]):
		jelly_icons[i].visible = true
	
	$fuel_lbl.text = "fuel: " + str(inv["fuel"]) + "/3"
	$compass_lbl.text = "compass: " + str(inv["compass"]) + "/1"
	$jelly_lbl.text = "jelly: " + str(inv["jelly"]) + "/2"
	
	$exp_btn.position = exp_btn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_exp_btn_pressed():
	var exp_popup = popup.instantiate()
	get_parent().add_child(exp_popup)
