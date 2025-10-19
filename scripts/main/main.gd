extends Node2D

@onready var counter := $interface/counter as Label
# temp testing for manually placed star
@onready var star := $star1/Area2D as Node2D

var star1 = preload("res://scenes/characters/star_1.tscn")
var menu = preload("res://scenes/main/menu.tscn")

var stars = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if star:
		star.star_collected.connect(_update_counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta): 
	pass

func _update_counter():
	stars += 1
	counter.text = str(stars)
