extends Node2D

@onready var interface := $interface
@onready var counter := $interface/counter as Label
@onready var timer := $Timer as Timer
# temp testing for manually placed star
#@onready var star := $star1/Area2D as Node2D

#interface.menu_open.connect(_update_counter)

var star1 = preload("res://scenes/characters/star_1.tscn")

var stars = 0
var ulcorner = Vector2(400, 50)
var brcorner = Vector2(1230, 670) 
var star_coords = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#if star:
		#star.star_collected.connect(_update_counter)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Randomized clickable stars
func _update_counter(pos):
	star_coords.remove_at(star_coords.find(pos))
	stars += 1
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
	pass

func save_progress():
	Save.save_data.stars = star_coords
	Save.save_game()
	print(Save.save_data.stars)
