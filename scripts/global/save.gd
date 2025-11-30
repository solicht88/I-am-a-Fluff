extends Button

# only testing one save file for now
const save_location = "user://saves/SaveFile.json"

var star1 = preload("res://scenes/characters/star_1.tscn")
var save_data: Dictionary = {
	"counter": 0, # count number of stars
	"stars": [], # keep track of spawned stars coordinates
	"gaze_lvl": 1,
	"wish_lvl": 1,
	"string_lvl": 1,
	"price_mult": 1,
	"inventory": {} # dictionary to store shop items
}

func save_game():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()

# TODO
# load existing stars, balance, levels, and inv
func load_game():
	pass

# possibly temp? will see how full save/load files go later in dev
func load_stars(coords):
	for pos in coords:
		var new_star = star1.instantiate()
		add_child(new_star)
		new_star.set_position(pos)
		#new_star.get_node("Area2D").star_collected.connect(_update_counter)
