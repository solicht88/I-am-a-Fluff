extends Control

var menu = preload("res://scenes/main/menu.tscn")
var info = preload("res://scenes/main/info_popup.tscn")

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
	'''
	get_parent().add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/upgrade/upgrade.tscn")
	'''


func _on_menu_pressed():
	var menu_ui = menu.instantiate()
	get_parent().add_child(menu_ui)
	menu_open.emit()


func _on_info_pressed():
	var info_ui = info.instantiate()
	get_parent().add_child(info_ui)


func _on_store_pressed():
	change_scene.emit()
	'''
	get_parent().add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/store/store.tscn")
	'''
