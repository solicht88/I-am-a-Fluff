extends Control

signal item_bought

var save_data = Save.save_data
var inv = Save.save_data.inventory
var item_data

var cur_item = ""
var shop_mems = ["lotus", "candle", "photo"]
var cur_mem = ""

@onready var counter_label := $counter as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	if save_data.exp_lvl < 3:
		cur_mem = shop_mems[save_data.exp_lvl]
	else:
		cur_mem = shop_mems[2]
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
	
	counter_label.text = str(save_data.counter)
	$store/memento/Label.text = Data.item_data[cur_mem][1]
	$store/memento/TextureRect.texture = Data.item_data[cur_mem][0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	'''
	get_parent().add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	'''
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
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
	var owned_lbl = selection.get_node("owned")
	var buy_btn = selection.get_node("buy_btn")
	
	var cur_item_data = Data.item_data[item]
	
	display_img.texture = cur_item_data[0]
	display_img.scale = Vector2(0.186, 0.186)
	name_lbl.text = cur_item_data[1]
	desc_lbl.text = cur_item_data[2] + cur_item_data[3]
	owned_lbl.text = "x" + str(inv[item]) + " owned"
	
	cur_item = item
	
	if inv[item] == Data.item_max[item]:
		buy_btn.disabled = true
		buy_btn.text = "sold out"
		buy_btn.set_default_cursor_shape(Control.CURSOR_ARROW)
	elif save_data.counter < Data.item_cost[item]:
		buy_btn.disabled = true
		buy_btn.text = "buy"
		buy_btn.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		buy_btn.disabled = false
		buy_btn.text = "buy"
		buy_btn.set_default_cursor_shape(Control.CURSOR_POINTING_HAND)

# fuel preview
func _on_fuel_mouse_entered():
	_mouse_entered()

func _on_fuel_mouse_exited():
	_mouse_exited()

func _on_fuel_gui_input(event):
	if event.is_action_pressed("leftclick"):
		#print("selected!")
		_display_item("fuel")


# telescope preview
func _on_telescope_mouse_entered():
	_mouse_entered()


func _on_telescope_mouse_exited():
	_mouse_exited()


func _on_telescope_gui_input(event):
	if event.is_action_pressed("leftclick"):
		_display_item("telescope")


# compass preview
func _on_compass_mouse_entered():
	_mouse_entered()

func _on_compass_mouse_exited():
	_mouse_exited()

func _on_compass_gui_input(event):
	if event.is_action_pressed("leftclick"):
		_display_item("compass")


# flower preview
func _on_flower_mouse_entered():
	_mouse_entered()

func _on_flower_mouse_exited():
	_mouse_exited()

func _on_flower_gui_input(event):
	if event.is_action_pressed("leftclick"):
		_display_item("flower")


# orange jelly preview
func _on_jelly_mouse_entered():
	_mouse_entered()

func _on_jelly_mouse_exited():
	_mouse_exited()

func _on_jelly_gui_input(event):
	if event.is_action_pressed("leftclick"):
		_display_item("jelly")


# memento shop preview
func _on_memento_mouse_entered():
	_mouse_entered()

func _on_memento_mouse_exited():
	_mouse_exited()

func _on_memento_gui_input(event):
	if event.is_action_pressed("leftclick"):
		_display_item(cur_mem)


func _on_buy_btn_pressed():
	_buy_item(cur_item)

func _buy_item(item: String):
	var cost = Data.item_cost[item]
	if cost <= save_data.counter:
		inv[item] += 1
		save_data.counter -= cost
		
		_display_item(item)
		counter_label.text = str(save_data.counter)
		
		if item == cur_mem:
			Data.cutscene_key = cur_mem
			
			Global.fade_in()
			await get_tree().create_timer(0.5).timeout
			
			#get_tree().change_scene_to_file("res://scenes/main/main.tscn")
			get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_node.tscn")
