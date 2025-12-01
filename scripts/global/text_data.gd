extends Node

# load item images
var fuel_img = preload("res://img/items/fuel_stone.png")
var compass_img = preload("res://img/items/compass.png")
var jelly_img = preload("res://img/items/orange_jelly.png")
var flower_img = preload("res://img/items/moon_flower.png")

# upgrades
var gaze_upg = ["5.0s --> 4.6s", "4.6s --> 4.2s", "4.2s --> 3.8s", "3.8s --> 3.4s", "3.4s --> 3.0s", "3.0s"]
var gaze_cost = [6, 12, 25, 50, 100, "N/A"]

var str_upg = ["1 --> 2", "2 --> 3", "3 --> 4", "4 per click"]
var str_cost = [25, 60, 150, "N/A"]

# store
var item_cost = {
	"fuel": 10,
	"compass": 50,
	"jelly": 15,
	"flower": 200
}

# format: [image, name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(item_cost["fuel"]*Save.save_data.price_mult) + " Stars\n", "Keeps Puff warm during explorations through the Milky Way"],
	"compass": [compass_img, "Compass", str(item_cost["compass"]*Save.save_data.price_mult) + " Stars\n", "Helps Puff to navigate where to go when exploring"],
	"jelly": [jelly_img, "Orange Jelly", str(item_cost["jelly"]*Save.save_data.price_mult) + " Stars\n", "Puff's favorite snack! Keeps her from going hungry while exploring"],
	"flower": [flower_img, "Moon Flower", str(item_cost["flower"]) + " Stars\n", "A peculiar flower. Hmm, Puff thinks Ma will like it!"]
}

var item_max: Dictionary = {
	"fuel": 3,
	"compass": 1,
	"jelly": 2,
	"flower": 1
}
