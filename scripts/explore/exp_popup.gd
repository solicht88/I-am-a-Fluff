extends Control

var save_data = Save.save_data
var inv = Save.save_data.inventory
var item_max = Data.item_max
var can_exp = true

 
# Called when the node enters the scene tree for the first time.
func _ready():
	for item in Data.exp_items:
		if inv[item] != item_max[item]:
			can_exp = false
			$Panel/exp_btn.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	if can_exp and save_data.exp_lvl < 2:
		$Panel/exp_btn.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_cancel_btn_pressed():
	queue_free()


func _on_exp_btn_pressed():
	save_data.exp_lvl += 1
	for item in Data.exp_items:
		inv[item] = 0
	Data.update_cost_data()
	
	# give associated memento w/ exploration
	if save_data.exp_lvl == 1:
		inv["dust"] = 1
		Data.cutscene_key = "dust"
	elif save_data.exp_lvl == 2:
		inv["ribbon"] = 1
		Data.cutscene_key = "ribbon"
	
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_node.tscn")
