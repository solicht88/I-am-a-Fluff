extends Control

@onready var gaze_label := $gaze_label as Label
@onready var gaze_lvl_txt := $gaze_lvl as Label

@onready var wish_label := $wish_label as Label
@onready var wish_lvl_txt := $wish_lvl as Label

@onready var string_label := $string_label as Label
@onready var string_lvl_txt := $string_lvl as Label

@onready var counter_label := $counter as Label

var save = Save.save_data
var upg = TextData

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()
	
	'''
	parent.add_child(Global.transition_node.instantiate())
	var transition = $"../transition_animation/transition_player"
	var transition_node = $"../transition_animation"
	transition_node.get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	$"../transition_animation".queue_free()
	'''
	
	_update_gaze_text()
	_update_wish_text()
	_update_string_text()
	counter_label.text = str(save.counter)


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


func _update_gaze_text():
	gaze_label.text = "Gaze Proficiency - Increase the rate which stars appear
	({upgr})
	Cost: {cost} stars".format({"upgr": upg.gaze_upg[save.gaze_lvl - 1], "cost": upg.gaze_cost[save.gaze_lvl - 1]})
	gaze_lvl_txt.text = "lvl " + str(save.gaze_lvl)
	
	if save.gaze_lvl == 6:
			$gaze_btn.disabled = true

func _on_gaze_btn_pressed():
	if save.counter >= upg.gaze_cost[save.gaze_lvl - 1]:
		save.counter -= upg.gaze_cost[save.gaze_lvl - 1]
		save.gaze_lvl += 1
		
		_update_gaze_text()
		counter_label.text = str(save.counter)


func _update_wish_text():
	wish_label.text = "Ma's Wish - Decrease cost of certain items in the store
	({upgr})
	Cost: {cost} stars".format({"upgr": upg.wish_upg[save.wish_lvl - 1], "cost": upg.wish_cost[save.wish_lvl - 1]})
	wish_lvl_txt.text = "lvl " + str(save.wish_lvl)
	
	if save.wish_lvl == 4:
		$wish_btn.disabled = true

func _on_wish_btn_pressed():
	if save.counter >= upg.wish_cost[save.wish_lvl - 1]:
		save.counter -= upg.wish_cost[save.wish_lvl - 1]
		save.wish_lvl += 1
	
	_update_wish_text()
	counter_label.text = str(save.counter)
	
	TextData.update_data()


func _update_string_text():
	string_label.text = "String Skill - Increase the stars earned per star clicked
	({upgr})
	Cost: {cost} stars".format({"upgr": upg.str_upg[save.str_lvl - 1], "cost": upg.str_cost[save.str_lvl - 1]})
	string_lvl_txt.text = "lvl " + str(save.str_lvl)
	
	if save.str_lvl == 4:
			$string_btn.disabled = true

func _on_string_btn_pressed():
	if save.counter >= upg.str_cost[save.str_lvl - 1]:
		save.counter -= upg.str_cost[save.str_lvl - 1]
		save.str_lvl += 1
		
		_update_string_text()
		counter_label.text = str(save.counter)
