extends Node

# load item images
var fuel_img = preload("res://img/items/fuel_stone.png")
var compass_img = preload("res://img/items/compass.png")

# upgrades
var gaze_upg = ["5.0s --> 4.6s", "4.6s --> 4.2s", "4.2s --> 3.8s", "3.8s --> 3.4s", "3.4s --> 3.0s", "3.0s"]
var gaze_cost = [6, 12, 25, 50, 100, "N/A"]

var str_upg = ["1 --> 2", "2 --> 3", "3 --> 4", "4 per click"]
var str_cost = [25, 60, 150, "N/A"]

# store
# format: [name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(100*Save.save_data.price_mult) + " Stars", "Keep Puff warm while travelling the Milky Way"],
	"compass": ["Compass", str(200*Save.save_data.price_mult) + " Stars", "Helps Puff keep track of directions while exploring"]
}
