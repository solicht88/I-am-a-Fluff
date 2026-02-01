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
var wish_cost = [80, 120, 180, "N/A"]

var str_upg = ["1 --> 2", "2 --> 3", "3 --> 4", "4 per click"]
var str_cost = [25, 80, 180, "N/A"]


# explore
var exp_items = ["fuel", "compass", "jelly"]


# store
var item_cost = {
	"fuel": 10,
	"compass": 30,
	"jelly": 15,
	"telescope": 180,
	"flower": 120,
	"lotus": 80,
	"candle": 175,
	"photo": 250
}

var og_item_cost = {
	"fuel": 10,
	"compass": 30,
	"jelly": 15,
	"telescope": 180,
	"flower": 120,
	"lotus": 80,
	"candle": 175,
	"photo": 250
}


# format: [image, name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(item_cost["fuel"]) + " Stars\n", "Keeps Puff warm during explorations through the Milky Way"],
	"telescope": [telescope_img, "Telescope", str(item_cost["telescope"]) + " Stars\n", "A nice telescope. Groups up to 4 stars to be collected together."],
	"compass": [compass_img, "Compass", str(item_cost["compass"]) + " Stars\n", "Helps Puff to navigate where to go when exploring"],
	"jelly": [jelly_img, "Orange Jelly", str(item_cost["jelly"]) + " Stars\n", "Puff's favorite snack! Keeps her from going hungry while exploring"],
	"flower": [flower_img, "Moon Flower", str(item_cost["flower"]) + " Stars\n", "A peculiar flower. Attracts an additional star to Puff every 8 secs."],
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
func update_cost_data():
	#print(1 - (0.05 * (Save.save_data.wish_lvl - 1) + 0.05))
	var gaze_disc = 1
	var exp_mult = 1
	
	if Save.save_data.wish_lvl > 1:
		gaze_disc -= 0.05 * (Save.save_data.wish_lvl - 1) + 0.05
	
	if Save.save_data.exp_lvl > 0:
		exp_mult += 0.5 * Save.save_data.exp_lvl + 0.5
	
	
	for key in item_cost:
		item_cost[key] = round(og_item_cost[key] * gaze_disc)
		if key in exp_items:
			item_cost[key] = round(og_item_cost[key] * exp_mult)
	
	for key in item_data:
		item_data[key][2] = str(item_cost[key]) + " Stars\n"


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


# cutscene stuff
# loading progression / mementos cutscene art
var open_cutscene = preload("res://img/cutscenes/opening.png")
var dust_cutscene = preload("res://img/cutscenes/stardust.png")
var ribbon_cutscene = preload("res://img/cutscenes/ribbon.png")
var lotus_cutscene = preload("res://img/cutscenes/lotus.png")
var candle_cutscene = preload("res://img/cutscenes/candle.png")
var photo_cutscene = preload("res://img/cutscenes/photo.png")

# loading ending cutscenes art
var end_cutscene_0 = preload("res://img/cutscenes/end_0.png")
var end_cutscene_1 = preload("res://img/cutscenes/end_1.png")
var choice_cutscene = preload("res://img/cutscenes/end_truth.png")
var choice_1_cutscene = preload("res://img/cutscenes/end_truth_1.png")
var choice_2_cutscene = preload("res://img/cutscenes/end_truth_2.png")
var final_cutscene = preload("res://img/cutscenes/end_finale.png")

# key changes depending on cutscene to play
var cutscene_key = "open"

# format: cutscene_key: [img, [name1, dialogue1], [name2, dialogue2], ...]
# TODO: add indicators for scene transitions/sfx? or fade in/out in middle of scenes
# could also reformat this so theres less name repitition n stuff? if theres time
var cutscene_data = {
	"open": [
		open_cutscene,
		["Puff", "I am a Fluff.
		My name is Puff."],
		["Puff", "Puff is on an adventure to find Ma!"],
		["Puff", "Ma left to explore the Milky Way a while ago, but still hasn't returned..."],
		["Puff", "Well, surely Ma is just a bit lost! Puff will definitely find her!"],
		["Puff", "But, uh...Puff may be low on fuel.
		Possibly now is a good time to take a break!"],
		["Puff", "That star looks good! Puff will go land on it. Hopefully it has some sort of fuel!"]
		],
	"dust": [
		dust_cutscene,
		["Puff", "Woah...!!"],
		["Puff", "Ma, look!
		There's so many lights in the sky!"],
		["Ma", "Careful, Puff!
		You're too close to the railing!"],
		["Ma", "Ahaha, you're right, little Puff. There's many stars tonight!
		Usually the sky isn't this clear. Aren't we lucky?"],
		["Puff", "Stars...
		Is that what the lights in the sky are called?"],
		["Ma", "That's right! They are called stars.
		Thousands of stars live in the sky, though we usually can't see most of them."],
		["Ma", "Stars are mostly made of gas and are extremely hot.
		However, there's a legend that every once in a while, a star begins to weep and drops 'stardust.'
		Do you believe the tale, Puff?"],
		["Puff", "Mmm... Sounds more like a fairytale for human children, Ma.
		Puff is smarter than that! You don't need to tell Puff such strange stories!"],
		["Ma", "Well, normally it would be, but this one might just be real.
		See? Ma managed to find some stardust a long time ago. Isn't that wonderful?"],
		["Puff", "Woah..."],
		["Puff", "This really came from a star? It isn't just some glitter you bought, right?"],
		["Ma", "Of course not! Ma won't lie about something like this.
		In fact, I saw the stars cry many times before. They cry for many reasons."],
		["Ma", "Here, you can have this. I have much more stardust in my room, after all.
		You seem interested, Puff. Ma can tell you all kinds of stories about the stars, if you'd like."],
		["Puff", "Ooo...yes please! Thank you, Ma!"]
	],
	"ribbon": [
		ribbon_cutscene,
		["Ma", "Oh no! How'd you get in this box, Puff?"],
		["Ma", "Listen, I understand you really love this red ribbon, but you can't make a mess with it.
		This is Ma's craft box. It's off limits from now on, okay?
		Look, the ribbon has unravelled everywhere."],
		["Puff", "Okay... I'm sorry, Ma..."],
		["Ma", "...Aw, don't be so upset, little Puff!
		Here, we can roll the ribbon back around the cardboard together.
		That way we'll be done cleaning much faster!"],
		["Puff", "Woah, Ma is really fast at rolling the ribbon...!
		It's such a pretty red color, Puff wanted to learn how to use it like Ma does..."],
		["Ma", "I see, you just wanted to learn how to tie the ribbon?
		Hehe, looks like it was a good idea to dress you in this ribbon after all!"],
		["Ma", "You may not be able to do it the same way Ma does.
		Don't get too frustrated at first, alright? It takes time to learn."],
		["Ma", "Here, watch carefully. First, I wrap the the ribbon around these two fingers.
		Then, bring the end back around and wrap it around the loop between these fingers."],
		["Puff", "Huh..."],
		["Ma", "Finally, tuck the loose end into the center, and adjust until you're satisfied!"],
		["Ma", "Hm, I suppose you don't exactly have hands to do it this way...
		Let's go find something you can wrap the ribbon around."],
		["Puff", "Ooh, those pencil crayons Ma bought Puff the other day could work!
		Follow Puff, Ma! Puff's going to need some help, but Puff wants to get it right!"],
		["Ma", "Alright, lead the way, little Puff."]
	],
	"lotus": [
		lotus_cutscene,
		["Puff", "Those are some interesting flowers, Ma!
		They're growing on the water!"],
		["Ma", "That's a lotus flower, Puff. Ma used to see them a lot when she was younger."],
		["Puff", "Is this an edible flower, Ma? Can Puff try it?"],
		["Ma", "Not this one, Puff. Let's leave this one for the animals in the pond."],
		["Puff", "Ma, have you ever eaten this flower before?"],
		["Ma", "Well, not really the flower, no. My family liked to cook the root.
		I'll buy some from the grocery store for you next time."],
		["Puff", ""]
	]
}
