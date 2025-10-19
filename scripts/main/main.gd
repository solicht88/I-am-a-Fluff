extends Node2D

@onready var interface := $interface as Control
@onready var counter := $interface/counter as Label
@onready var timer := $Timer as Timer
# temp testing for manually placed star
#@onready var star := $star1/Area2D as Node2D

var star1 = preload("res://scenes/characters/star_1.tscn")

var ulcorner = Vector2(400, 50)
var brcorner = Vector2(1230, 670)
var stars = Save.save_data.counter
var star_coords = Save.save_data.stars

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()	
	interface.menu_open.connect(_menu_opened)
	interface.change_scene.connect(save_progress)
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
	var new_star = star1.instantiate()
	var coords = _get_random_point(ulcorner, brcorner)
	
	star_coords.append(coords)
	add_child(new_star)
	new_star.set_position(coords)
	new_star.get_node("Area2D").star_collected.connect(_update_counter)

func _on_timer_timeout():
	_spawn_star()
	timer.start()

# Menu
func _menu_opened():
	$menu_ui.save_data.connect(save_progress)
	#print("connected")

func save_progress():
	Save.save_data.counter = stars
	Save.save_data.stars = star_coords
	#Save.save_game()
	print("saved!")

# possibly temp? will see how full save/load files go
func _load_stars(coords):
	for pos in coords:
		var new_star = star1.instantiate()
		add_child(new_star)
		new_star.set_position(pos)
		new_star.get_node("Area2D").star_collected.connect(_update_counter)
