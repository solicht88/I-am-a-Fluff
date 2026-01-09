extends Control

@onready var parent = $"../"

var transition_animation = preload("res://scenes/transition_animation.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fade_out()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_btn_pressed():	
	Global.fade_in()
	#print('ready')
	
	'''
	parent.add_child(transition_animation.instantiate())
	var transition = $"../transition_animation/transition_player"
	transition.play("fade_in")
	'''
	await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	# TODO: run opening cutscene
	Data.cutscene_key = "open"
	get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_node.tscn")


func _on_load_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()
