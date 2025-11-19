extends Control

signal item_bought

var save = Save.save_data

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	
	await parent.ready
	
	Global.fade_out()
	# parent.add_child(Global.transition_node.instantiate())
	'''
	var transition = $"../transition_animation/transition_player"
	var transition_node = $"../transition_animation"
	transition_node.get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	
	
	var transition_node = Global.transition_node.instantiate()
	add_child(transition_node)
	var transition = $transition_animation/transition_player
	transition_node.get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	transition_node.queue_free()
	'''

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

# item = string of item's name
func _display_item(item: String):
	var selection = $"selection"
	var display_img = selection.get_node("display/TextureRect")
	var name_lbl = selection.get_node("name")
	var desc_lbl = selection.get_node("description")
	
	var cur_item_data = TextData.item_data[item]
	
	display_img.texture = cur_item_data[0]
	name_lbl.text = cur_item_data[1]
	desc_lbl.text = cur_item_data[2]

# fuel preview
func _on_fuel_mouse_entered():
	_mouse_entered()

func _on_fuel_mouse_exited():
	_mouse_exited()

func _on_fuel_gui_input(event):
	if event.is_action_pressed("leftclick"):
		#print("selected!")
		_display_item("fuel")


# compass preview
func _on_compass_mouse_entered():
	_mouse_entered()

func _on_compass_mouse_exited():
	_mouse_exited()

func _on_compass_gui_input(event):
	pass # Replace with function body.


# flower preview
func _on_flower_mouse_entered():
	_mouse_entered()

func _on_flower_mouse_exited():
	_mouse_exited()

func _on_flower_gui_input(event):
	pass # Replace with function body.


# orange jelly preview
func _on_jelly_mouse_entered():
	_mouse_entered()

func _on_jelly_mouse_exited():
	_mouse_exited()

func _on_jelly_gui_input(event):
	pass # Replace with function body.


# memento shop preview
func _on_memento_mouse_entered():
	_mouse_entered()

func _on_memento_mouse_exited():
	_mouse_exited()

func _on_memento_gui_input(event):
	pass # Replace with function body.

# TODO: buy item if player has enough stars
func _on_buy_btn_pressed():
	pass # Replace with function body.
