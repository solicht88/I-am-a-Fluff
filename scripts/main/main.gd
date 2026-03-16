extends Node2D

@onready var interface := $interface as Control
@onready var counter := $interface/counter as Label
@onready var timer := $Timer as Timer
@onready var flower_timer := $FlowerTimer as Timer
@onready var tele_timer := $TeleTimer as Timer
@onready var bg_sprite := $bg
# temp testing for manually placed star
#@onready var star := $star1/Area2D as Node2D

var star1 = preload("res://scenes/characters/star_1.tscn")
var star2 = preload("res://scenes/characters/star_2.tscn")
var star3 = preload("res://scenes/characters/star_3.tscn")
#var transition_load = preload("res://scenes/transition_animation.tscn")
#var transition_animation = transition_load.instantiate()
var star_scenes = [star1, star2, star3]

var save_data = Save.save_data

var ulcorner = Vector2(400, 50)
var brcorner = Vector2(1230, 670)
var stars = save_data.counter
var star_coords = save_data.stars


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
	bg_sprite.texture = Data.main_bgs[save_data.exp_lvl]
	
	Global.fade_out()
	Audio.play_bgm()
	
	randomize()	
	interface.menu_open.connect(_menu_opened)
	interface.change_scene.connect(save_progress)
	counter.text = str(stars)
	#_load_stars(star_coords)
	timer.start()
	call_deferred("_load_stars", star_coords)
	
	# moon flower spawns an additional star every 6 seconds
	if save_data.inventory["flower"]:
		flower_timer.start()
	# telescope spawns an additional star every 4 seconds
	if save_data.inventory["telescope"]:
		tele_timer.start()
	
	# TODO: add pop-up for obtained memento after increase in exp_lvl (future update?)
	
	# temp to trash debug save file
	#OS.move_to_trash(ProjectSettings.globalize_path("user://SaveFile.json"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Randomized clickable stars
func _update_counter(pos):
	star_coords.remove_at(star_coords.find(pos))
	stars += 1 * save_data.str_lvl
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
	
	# (maybe in future update/remake) telescope function: connects up to 4 stars together in "groups"


func _on_timer_timeout():
	_spawn_star()
	timer.wait_time = 5 - 0.4 * (save_data.gaze_lvl - 1)
	#print(timer.wait_time)
	timer.start()


func _on_flower_timer_timeout():
	#print("moon flower in action!")
	_spawn_star()
	flower_timer.start()


func _on_tele_timer_timeout():
	#print("telescope in action!")
	_spawn_star()
	tele_timer.start()


# Menu
func _menu_opened():
	$menu_ui.save_data.connect(save_progress)
	#print("connected")


func save_progress():
	save_data.counter = stars
	save_data.stars = star_coords
	#Save.save_game()
	#print("saved!")


# possibly temp? will see how full save/load files go (keeping this for now)
func _load_stars(coords):
	#print(coords)
	for pos in coords:
		#print(pos)
		var new_star = star_scenes[randi_range(0, 2)].instantiate()
		add_child(new_star)
		new_star.set_position(pos)
		new_star.get_node("Area2D").star_collected.connect(_update_counter)
		
		# ensure star is visible when loading
		new_star.get_node("Sprite2D").self_modulate.a = 255
