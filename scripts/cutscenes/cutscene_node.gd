extends Node2D

var key = Data.cutscene_key
var scene_data = Data.cutscene_data[key]
var scene_img = scene_data[0]
#var dialogue = scene_data

var the_end = false

signal dial_ready
signal dial_finished
signal play_cutscene

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	$bg.texture = scene_img
	Global.fade_out()
	
	if key == "end_0":
		Audio.play_ending_bgm()
	else:
		Audio.play_cutscene_bgm()
	
	dial_finished.connect(_end_scene)
	
	# show dialogue box after showing cutscene for a few seconds
	await get_tree().create_timer(1).timeout
	$dialogue_box.visible = true
	dial_ready.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _end_scene():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	
	'''
	if key == "end_0":
		pass
	else:
		get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	'''
	
	# TODO: check if we are at an ending n change behaviour
	# try checking if current key is equal to dialogue_box key
	# if not, continue cutscene for selected ending
	# otherwise, end cutscene
	if key != $dialogue_box.key:
		await _update_data()
		_play_scene()
	elif the_end:
		# go to title screen after ending ends instead of main screen
		Audio.stop_audio()
		get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
	else:
		Audio.stop_audio()
		get_tree().change_scene_to_file("res://scenes/main/main.tscn")


# plays cutscenes (mostly useful for endings) 
func _play_scene():
	$Panel.visible = true
	$bg.texture = scene_img
	await get_tree().create_timer(0.05).timeout
	# an honest brute force fix for the animation using a panel
	$Panel.visible = false
	Global.fade_out()
	
	await get_tree().create_timer(1).timeout
	$dialogue_box.visible = true
	dial_ready.emit()


func _update_data():
	key = $dialogue_box.key
	scene_data = Data.cutscene_data[key]
	scene_img = scene_data[0]
