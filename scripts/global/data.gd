extends Node

# load item images
var fuel_img = preload("res://img/items/fuel_stone.png")
var telescope_img = preload("res://img/items/telescope.png")
var compass_img = preload("res://img/items/compass.png")
var jelly_img = preload("res://img/items/orange_jelly.png")
var flower_img = preload("res://img/items/moon_flower.png")
var lotus_img = preload("res://img/mementos/lotus.png")
var candle_img = preload("res://img/mementos/candle.png")
var photo_img = preload("res://img/mementos/polaroid.png")


# load main screen backgrounds
var main_bg_1 = preload("res://img/backgrounds/sky1.png")
var main_bg_2 = preload("res://img/backgrounds/sky2.png")
var main_bg_3 = preload("res://img/backgrounds/sky3.png")
var main_bg_4 = preload("res://img/backgrounds/sky4.png")
var main_bgs = [main_bg_1, main_bg_2, main_bg_3, main_bg_4]

# load exploration backgrounds
var exp_bg_1 = preload("res://img/backgrounds/expl_1.png")
var exp_bg_2 = preload("res://img/backgrounds/expl_2.png")
var exp_bg_3 = preload("res://img/backgrounds/expl_3.png")
var exp_bgs = [exp_bg_1, exp_bg_2, exp_bg_3]


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
	"telescope": 160,
	"flower": 100,
	"lotus": 80,
	"candle": 150,
	"photo": 200
}

# format: [image, name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(item_cost["fuel"]) + " Stars\n", "Keeps Puff warm during explorations through the Milky Way"],
	"telescope": [telescope_img, "Telescope", str(item_cost["telescope"]) + " Stars\n", "It's a bit expensive, but Puff can spot more stars with this!"],
	"compass": [compass_img, "Compass", str(item_cost["compass"]) + " Stars\n", "Helps Puff to navigate where to go when exploring"],
	"jelly": [jelly_img, "Orange Jelly", str(item_cost["jelly"]) + " Stars\n", "Puff's favorite snack! Keeps her from going hungry while exploring"],
	"flower": [flower_img, "Moon Flower", str(item_cost["flower"]) + " Stars\n", "A peculiar flower. Hmm, Puff thinks Ma will like it!"],
	"lotus": [lotus_img, "Lotus Flower", str(item_cost["lotus"]) + " Stars\n", "A pink lotus flower from... Earth? How'd this get here?"],
	"candle": [candle_img, "Chamberstick", str(item_cost["candle"]) + " Stars\n", "An old chamberstick! Too bad Puff doesn't have a lighter."],
	"photo": [photo_img, "Photograph", str(item_cost["photo"]) + " Stars\n", "Is that Puff in the photo? If we have extra stars, please let Puff buy this!"]
}

var item_max: Dictionary = {
	"fuel": 3,
	"compass": 1,
	"jelly": 2,
	"telescope": 1,
	"flower": 1,
	"lotus": 1,
	"candle": 1,
	"photo": 1
}

# updates store item costs when upgrading for store sales
# TODO: add shop price multiplier for each exp_lvl
func update_data():
	#print(1 - (0.05 * (Save.save_data.wish_lvl - 1) + 0.05))
	for key in item_cost:
		item_cost[key] = round(item_cost[key] * (1 - (0.05 * (Save.save_data.wish_lvl - 1) + 0.05)))
	for key in item_data:
		item_data[key][2] = str(item_cost[key]) + " Stars\n"


# explore
var exp_items = ["fuel", "compass", "jelly"]


# mementos
# format: [name, description]
var mem_data: Dictionary = {
	"dust": ["Stardust", "Some leftover stardust Ma gave to Puff.\nNow that Puff thinks about it, why did Ma collect so much?"],
	"ribbon": ["Extra Ribbon", "Excess ribbon from the piece Puff wears.\nMa said wearing a red ribbon will bring Puff lots of luck!"],
	"lotus": ["Lotus Flower", "A common flower from Ma's birthplace on Earth.\nSeems kinda ordinary, though... well, if Ma likes them, Puff does too."],
	"candle": ["Black Chamberstick", "Ma's old chamberstick. It's holding an unlit candle.\nPuff likes it! It keeps us warm for a long time in the cold."],
	"photo": ["Polaroid Photo", "A polaroid photo of Puff when we first met Ma.\nAww, Puff was so small! Puff wonders how long ago this was taken?"],
	"unknown": ["A Memento from Ma", "A memento that reminds Puff of Ma.\nPuff can't remember what it was too clearly..."]
}
