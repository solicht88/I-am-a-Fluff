extends Control

signal item_bought

var save = Save.save_data

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	
	await parent.ready
	parent.add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	var transition_node = $"../transition_animation"
	transition_node.get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_exit_pressed():
	get_parent().add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func _mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

# fuel preview
func _on_fuel_mouse_entered():
	_mouse_entered()

func _on_fuel_mouse_exited():
	_mouse_exited()

# compass preview
func _on_compass_mouse_entered():
	_mouse_entered()

func _on_compass_mouse_exited():
	_mouse_exited()

# flower preview
func _on_flower_mouse_entered():
	_mouse_entered()

func _on_flower_mouse_exited():
	_mouse_exited()

# orange jelly preview
func _on_jelly_mouse_entered():
	_mouse_entered()

func _on_jelly_mouse_exited():
	_mouse_exited()

# memento shop preview
func _on_memento_mouse_entered():
	_mouse_entered()

func _on_memento_mouse_exited():
	_mouse_exited()
