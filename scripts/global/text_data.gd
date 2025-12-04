extends Node

# load item images
var fuel_img = preload("res://img/items/fuel_stone.png")
var compass_img = preload("res://img/items/compass.png")
var jelly_img = preload("res://img/items/orange_jelly.png")
var flower_img = preload("res://img/items/moon_flower.png")

# upgrades
var gaze_upg = ["5.0s --> 4.6s", "4.6s --> 4.2s", "4.2s --> 3.8s", "3.8s --> 3.4s", "3.4s --> 3.0s", "3.0s"]
var gaze_cost = [6, 12, 25, 50, 100, "N/A"]

var wish_upg = ["0% --> 10% off", "10% --> 15% off", "10% --> 20% off", "20% off"]
var wish_cost = [80, 120, 220, "N/A"]

var str_upg = ["1 --> 2", "2 --> 3", "3 --> 4", "4 per click"]
var str_cost = [25, 80, 180, "N/A"]

# store
var item_cost = {
	"fuel": 10,
	"compass": 50,
	"jelly": 15,
	"flower": 100,
	"mem_1": 0
}

# format: [image, name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(item_cost["fuel"]) + " Stars\n", "Keeps Puff warm during explorations through the Milky Way"],
	"compass": [compass_img, "Compass", str(item_cost["compass"]) + " Stars\n", "Helps Puff to navigate where to go when exploring"],
	"jelly": [jelly_img, "Orange Jelly", str(item_cost["jelly"]) + " Stars\n", "Puff's favorite snack! Keeps her from going hungry while exploring"],
	"flower": [flower_img, "Moon Flower", str(item_cost["flower"]) + " Stars\n", "A peculiar flower. Hmm, Puff thinks Ma will like it!"]
}

var item_max: Dictionary = {
	"fuel": 3,
	"compass": 1,
	"jelly": 2,
	"flower": 1
}

func update_data():
	print(1 - (0.05 * (Save.save_data.wish_lvl - 1) + 0.05))
	for key in item_cost:
		item_cost[key] = round(item_cost[key] * (1 - (0.05 * (Save.save_data.wish_lvl - 1) + 0.05)))
	for key in item_data:
		item_data[key][2] = str(item_cost[key]) + " Stars\n"
