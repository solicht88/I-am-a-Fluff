extends Control

@onready var parent = $"../"

var transition_animation = preload("res://scenes/transition_animation.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_btn_pressed():
	var parent = get_parent()
	
	await parent.ready
	Global.fade_out()
	
	'''
	parent.add_child(transition_animation.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	'''


func _on_load_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()
