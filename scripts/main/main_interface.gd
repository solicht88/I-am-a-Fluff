extends Control

var menu = preload("res://scenes/main/menu.tscn")

signal menu_open
signal change_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_upgrade_pressed():
	change_scene.emit()
	get_tree().change_scene_to_file("res://scenes/upgrade/upgrade.tscn")


func _on_menu_pressed():
	var menu_ui = menu.instantiate()
	get_parent().add_child(menu_ui)
	menu_open.emit()
