extends Button

# only testing one save file for now
const save_location = "user://saves/SaveFile.json"

var save_data: Dictionary = {
	"counter": 0,
	"stars": [],
	"gaze_lvl": 1,
	"wish_lvl": 1,
	"string_lvl": 1
}

func save_game():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()

func load_game():
	pass
