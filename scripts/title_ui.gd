extends Control

@onready var parent = $"../"

var transition_animation = preload("res://scenes/transition_animation.tscn")
var credits = preload("res://scenes/credits_popup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fade_out()
	Audio.play_title_bgm()
	
	if Save.ending_viewed:
		$play_btn.text = "Continue"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_btn_pressed():	
	Global.fade_in()
	#print('ready')
	Audio.stop_audio()
	await get_tree().create_timer(0.5).timeout
	
	if Save.ending_viewed:
		get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	else:
		'''
		parent.add_child(transition_animation.instantiate())
		var transition = $"../transition_animation/transition_player"
		transition.play("fade_in")
		'''
		# run opening cutscene
		Data.cutscene_key = "open"
		get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_node.tscn")


func _on_credits_btn_pressed():
	var credits_popup = credits.instantiate()
	get_parent().add_child(credits_popup)


func _on_quit_btn_pressed():
	get_tree().quit()
