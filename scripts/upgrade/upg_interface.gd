extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_gaze_btn_pressed():
	pass # Replace with function body.


func _on_wish_btn_pressed():
	pass # Replace with function body.


func _on_string_btn_pressed():
	pass # Replace with function body.
