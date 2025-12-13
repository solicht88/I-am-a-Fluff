extends Button

# only testing one save file for now
const save_location = "user://saves/SaveFile.json"

var star1 = preload("res://scenes/characters/star_1.tscn")

var save_data: Dictionary = {
	"counter": 0, # count number of stars
	"stars": [], # keep track of spawned stars coordinates
	"gaze_lvl": 1,
	"wish_lvl": 1,
	"str_lvl": 1,
	"exp_lvl": 0,
	"inventory": {
		"fuel": 3,
		"compass": 1,
		"jelly": 2,
		"telescope": 0,
		"flower": 1,
		"dust": 0,
		"ribbon": 0,
		"lotus": 1,
		"candle": 0,
		"photo": 0
		}, # dictionary to store owned items
}

'''
"mementos": {
	"dust": false,
	"ribbon": false,
	"lotus": false,
	"candle": false,
	"photo": false
}'''

func save_game():
	pass
	'''
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()
	'''

# TODO: load balance, levels, inv from save file
func load_game():
	pass

# possibly temp? will see how full save/load files go later in dev
func load_stars(coords):
	for pos in coords:
		var new_star = star1.instantiate()
		add_child(new_star)
		new_star.set_position(pos)
		#new_star.get_node("Area2D").star_collected.connect(_update_counter)
