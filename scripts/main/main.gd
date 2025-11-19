extends Node2D

@onready var interface := $interface as Control
@onready var counter := $interface/counter as Label
@onready var timer := $Timer as Timer
# temp testing for manually placed star
#@onready var star := $star1/Area2D as Node2D

var star1 = preload("res://scenes/characters/star_1.tscn")
var star2 = preload("res://scenes/characters/star_2.tscn")
var star3 = preload("res://scenes/characters/star_3.tscn")
var transition_load = preload("res://scenes/transition_animation.tscn")
var transition_animation = transition_load.instantiate()
var star_scenes = [star1, star2, star3]

var ulcorner = Vector2(400, 50)
var brcorner = Vector2(1230, 670)
var stars = Save.save_data.counter
var star_coords = Save.save_data.stars

# Called when the node enters the scene tree for the first time.
func _ready():
	# transition
	'''
	add_child(transition_animation)
	var transition = $transition_animation/transition_player
	var transition_node = $transition_animation
	transition_node.get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	transition_node.queue_free()
	'''
	await ready
	Global.fade_out()
	
	randomize()	
	interface.menu_open.connect(_menu_opened)
	interface.change_scene.connect(save_progress)
	interface.change_scene.connect(Global.fade_in)
	counter.text = str(stars)
	timer.start()
	_load_stars(star_coords)
	
	# temp to trash debug save file
	#OS.move_to_trash(ProjectSettings.globalize_path("user://SaveFile.json"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Randomized clickable stars
func _update_counter(pos):
	star_coords.remove_at(star_coords.find(pos))
	stars += 1 * Save.save_data.string_lvl
	counter.text = str(stars)

func _get_random_point(ul: Vector2, br: Vector2) -> Vector2:
	var x_value = randi_range(ul.x, br.x)
	var y_value = randi_range(ul.y, br.y)
	var random_point = Vector2(x_value, y_value)
	return(random_point)

func _spawn_star():
	var new_star = star_scenes[randi_range(0, 2)].instantiate()
	var coords = _get_random_point(ulcorner, brcorner)
	
	star_coords.append(coords)
	add_child(new_star)
	new_star.set_position(coords)
	new_star.get_node("Area2D").star_collected.connect(_update_counter)
	
	# star appear animation
	var animation = new_star.get_node("AnimationPlayer")
	new_star.get_node("Sprite2D").self_modulate.a = 0
	animation.play("appear")

func _on_timer_timeout():
	_spawn_star()
	timer.wait_time = 5 - 0.4 * (Save.save_data.gaze_lvl - 1)
	#print(timer.wait_time)
	timer.start()

# Menu
func _menu_opened():
	$menu_ui.save_data.connect(save_progress)
	#print("connected")

func save_progress():
	Save.save_data.counter = stars
	Save.save_data.stars = star_coords
	#Save.save_game()
	#print("saved!")

# possibly temp? will see how full save/load files go
func _load_stars(coords):
	for pos in coords:
		var new_star = star1.instantiate()
		add_child(new_star)
		new_star.set_position(pos)
		new_star.get_node("Area2D").star_collected.connect(_update_counter)
