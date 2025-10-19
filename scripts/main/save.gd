extends Button

# only testing one save file for now
const save_location = "user://SaveFile.json"

var save_data: Dictionary = {
	"counter": 0,
	"world": 0,
	"stars": []
}

func save_game():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()

func load_game():
	pass
