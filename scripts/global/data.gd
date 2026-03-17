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
var gaze_cost = [3, 6, 8, 14, 20, "N/A"]

var wish_upg = ["0% --> 10% off", "10% --> 15% off", "10% --> 20% off", "20% off"]
var wish_cost = [15, 30, 45, "N/A"]

var str_upg = ["1 --> 2", "2 --> 3", "3 --> 4", "4 per click"]
var str_cost = [8, 20, 45, "N/A"]


# explore
var exp_items = ["fuel", "compass", "jelly"]


# store
var item_cost = {
	"fuel": 5,
	"compass": 15,
	"jelly": 5,
	"telescope": 60,
	"flower": 40,
	"lotus": 40,
	"candle": 60,
	"photo": 90
}

var og_item_cost = {
	"fuel": 5,
	"compass": 15,
	"jelly": 5,
	"telescope": 60,
	"flower": 40,
	"lotus": 40,
	"candle": 60,
	"photo": 90
}


# format: [image, name, price, description]
var item_data: Dictionary = {
	"fuel": [fuel_img, "Fuel Stone", str(item_cost["fuel"]) + " Stars\n", "Keeps Puff warm during explorations through the Milky Way"],
	"telescope": [telescope_img, "Telescope", str(item_cost["telescope"]) + " Stars\n", "A nice telescope. Helps Puff spot an additional star every 6 secs."],
	"compass": [compass_img, "Compass", str(item_cost["compass"]) + " Stars\n", "Helps Puff to navigate where to go when exploring"],
	"jelly": [jelly_img, "Orange Jelly", str(item_cost["jelly"]) + " Stars\n", "Puff's favorite snack! Keeps her from going hungry while exploring"],
	"flower": [flower_img, "Moon Flower", str(item_cost["flower"]) + " Stars\n", "A peculiar flower. Attracts an additional star to Puff every 4 secs."],
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
			item_cost[key] = round(item_cost[key] * exp_mult)
	
	for key in item_data:
		item_data[key][2] = str(item_cost[key]) + " Stars\n"


# mementos
# format: [name, description]
var mem_data: Dictionary = {
	"dust": ["Stardust", "Some leftover stardust Ma gave to Puff.\nNow that Puff thinks about it, how did Ma collect so much?"],
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
var finale_cutscene = preload("res://img/cutscenes/end_finale.png")

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
		["Puff", "Fluffs are... Well, Puff isn't actually sure.
		We're small, round, fluffy..."],
		["Puff", "Anyway! Puff is on an adventure to find Ma!"],
		["Puff", "Ma left Earth to explore the Milky Way a while ago, but still hasn't returned..."],
		["Puff", "Well, surely Ma is just a bit lost! Puff will definitely find her!"],
		["Puff", "But, uh...Puff may be low on fuel.
		Puff thinks now is a good time to take a break!"],
		["Puff", "Ooh, that star looks soft! Puff will go land on it. Hopefully we can refuel there!"]
		],
	"dust": [
		dust_cutscene,
		["Puff", "Woah...!"],
		["Puff", "Ma, look!
		There's so many lights in the sky!"],
		["Ma", "Careful, Puff!
		You can't lean over the balcony like that!"],
		["Ma", "Aha, you're right, little Puff. There are so many stars tonight!
		Usually the sky isn't this clear. Aren't we lucky?"],
		["Puff", "Stars...
		Is that what the lights in the sky are called?"],
		["Ma", "That's right! They are called stars.
		Thousands of stars live in the sky, though we can't see most of them."],
		["Ma", "Stars are mostly made of hydrogen and helium gas, and they are extremely hot."],
		["Ma", "However, there's a legend that every once in a while, a star begins to weep from the heat, and its tears become 'stardust.'
		What do you think? Do you believe in this tale, Puff?"],
		["Puff", "Mmm... Sounds more like a fairytale for human children, Ma.
		Puff is smarter than that! You don't need to tell Puff such strange stories!"],
		["Ma", "Well, it sounds strange, right? But this one might just be real.
		See? I managed to find some stardust, a long, long time ago. Isn't that wonderful?"],
		["Puff", "Woah..."],
		["Puff", "This really came from a star? It isn't just some glitter you bought, right?"],
		["Ma", "Of course not! I won't lie about small things like this.
		In fact, I saw the stars cry many times before. They weep for many reasons, more than just heat."],
		["Ma", "Here, you can have this. I have already collected plenty of stardust myself.
		It's my dream to become a star one day, after all."],
		["Ma", "Goodness, look at you, jumping around with so much energy! You really do like the stars, don't you?
		Here, if you're so curious, I can tell you all sorts of stories about the stars, dear Puff."],
		["Puff", "Ooo...yes, please! Thank you, Ma!"]
	],
	"ribbon": [
		ribbon_cutscene,
		["Ma", "Oh no! How'd you get in this box, Puff?"],
		["Ma", "Listen, I understand you really love this red ribbon, but you can't make a mess with it.
		This is Ma's craft box. It's off limits from now on, okay?
		Look, the ribbon has unravelled everywhere..."],
		["Puff", "Okay... I'm sorry, Ma..."],
		["Ma", "...Aw, don't be so upset, little Puff!
		Here, you can help me roll the ribbon back around the spool.
		It's not a big deal, and we can clean up faster together!"],
		["Puff", "Woah, Ma is really fast...!"],
		["Puff", "It's such a pretty red color, Puff wanted to learn how to use it like Ma does..."],
		["Ma", "I see, you just wanted to learn how to tie the ribbon?
		Hehe, looks like it was a good idea to dress you in this ribbon after all.
		Puff loves the color dearly, and it'll bring you plenty of luck!"],
		["Ma", "Puff may not be able to do it the same way as Ma does at first.
		Don't be too frustrated, alright? It takes time to learn, be patient with yourself."],
		["Ma", "Here, watch carefully. First, I wrap the the ribbon around these two fingers.
		Then, bring the end back between your fingers and wrap it around the loop."],
		["Puff", "Huh..."],
		["Ma", "Finally, tuck the loose end into the center, and adjust the ends to your liking!"],
		["Ma", "Hm, I suppose you don't exactly have hands to do it this way...
		Let's go find something you can wrap the ribbon around."],
		["Puff", "Ooh, those colored pencils Ma bought Puff the other day could work!
		Follow Puff, Ma! Puff's going to need some help, but Puff wants to get it right!"],
		["Ma", "Alright, then! Lead the way, little Puff."]
	],
	"lotus": [
		lotus_cutscene,
		["Puff", "Those are some interesting flowers, Ma!
		They're growing on the water!"],
		["Ma", "That's a lotus flower, Puff. I used to see them a lot when I was younger."],
		["Puff", "Is this an edible flower, Ma? Can Puff try it?"],
		["Ma", "Not this time, Puff. See how there aren't many left? Let's leave this one for the wildlife."],
		["Puff", "Ma, have you ever eaten this flower before?"],
		["Ma", "Well, not the flower itself, no. My family liked to cook the root.
		I'll buy some from the grocery store for you next time!
		You might not like the taste, though."],
		["Puff", "Well, any food is worth trying at least once! That's what you like to say, Ma!"],
		["Puff", "Are these flowers any special, Ma? They seem like normal pink flowers to Puff."],
		["Puff", "But, not in a bad way! They just seem pretty ordinary. Plain.
		What makes them different from the other pink flowers, apart from growing on water?"],
		["Ma", "Hmm, I'd say their unique trait really is about growing on the water."],
		["Ma", "If you want my opinion, I like how they look when fully bloomed. I like them more than most other flowers.
		They're more common in the region where I was born, too."],
		["Ma", "Maybe that makes me biased, but I really love the place I was born.
		We didn't have a whole lot back then, and life moved quickly at all times.
		Yet, these lotus flowers never budged. Always grew right back in a little pond by my home."],
		["Ma", "I suppose I just has a personal connection to these flowers, Puff.
		Ah, by the way, you don't have to like them just because I do."],
		["Puff", "...No! Puff likes the lotuses, Ma!
		They a nice shade of pink, and they bloom big across the water!"],
		["Puff", "So, Puff won't eat these flowers. Not a single one.
		Hopefully, many more of them bloom across this pond, and Ma can see them every day!"],
		["Ma", "That's sweet of you, little Puff!
		One day, when the water is covered in more lotus flowers, you can try eating one from this pond."],
		["Ma", "Let's try eating the root together first! Shall we go grocery shopping now?"]
	],
	"candle": [
		candle_cutscene,
		["Puff", "Brrr... It's suddenly so cold...
		When did the weather get so cold, Ma? Wasn't it sunny just yesterday?"],
		["Ma", "Seems like the sun left to take a break today. Stay still, Puff. Ma will light a candle."],
		["Ma", "The weather has been getting pretty cold as of late.
		Well, it's meant to get chilly at this time of year, anyway."],
		["Ma", "Hm, now that I think of it, I suppose it has been colder than previous years..."],
		["Puff", "Waah... Puff doesn't like the cold."],
		["Ma", "Just one second... There. Be careful, the flame is hot to touch.
		This should keep us warm for a while. I made sure to use the cinnamon scented one you like, Puff."],
		["Puff", "Yes, Puff can smell it. Thank you!"],
		["Puff", "What's this black plate thing called? It's not part of the candle.
		Ma places a candle into it, just like she did now, and it lets her carry the candle around."],
		["Ma", "That's a good question. This is called a chamberstick.
		It was gifted to me from my grandparents, who got it from their grandparents, and so on."],
		["Ma","They used to be use as a portable light source.
		Though, they aren't common to have anymore, since flashlights and electricity are more convenient."],
		["Puff", "Then, why do these exist? Puff likes it, it keeps us warm, but it doesn't sound like it has much purpose to humans."],
		["Ma", "There was a time before electricity could be used.
		Candles were convenient, and the chamberstick prevented wax from spilling everywhere."],
		["Ma", "Well, you are right that these don't serve much purpose in modern days.
		But as long as little Puff needs warmth, this chamberstick will still have a purpose."],
		["Ma", "When you grow older, Puff, I'll give this old chamberstick to you.
		Make sure to take good care of it when that time comes, alright?"]
	],
	"photo": [
		photo_cutscene,
		["Puff", "Rustling, rustling..."],
		["Ma", "Huh? What's that noise?
		Is someone there?"],
		["Puff", "Fff...fwa! Rustle, rustle!"],
		["Ma", "Oh! Goodness, you scared me!
		What's your name, little one?"],
		["Puff", "Mmm, F...Fluff! Puff!"],
		["Ma", "Ah, hmm... Fluff, Puff? Could it be...are you a Fluff?"],
		["Puff", "Fluh...Puff! Puff! Mm...
		Rectangle, click, snap. Puff, like!"],
		["Ma", "The camera shutter? You like the sound of it clicking when I take a photo?"],
		["Ma", "Hehe, here, let me take your photo. Say cheese!"],
		["Ma", "Well, how is it? Do you like it, Puff?"],
		["Puff", "F...fwua! Cool! Puff like, lots!"],
		["Puff", "Rectangle, clicky rectangle, called what?"],
		["Ma", "Camera. This is called a camera. It takes pictures, or photos, when it clicks.
		This is the photo I took of you now. If you wait a few minutes, I can print it."],
		["Ma", "Where's your Ma, little Puff? Isn't it dangerous for Fluffs to wander without a guardian?"],
		["Puff", "Puff, one. One Fluff, Puff. Ma, who? Ma, you?"],
		["Ma", "Huh? No, no, I mean, do you not have a parent? Or a guardian? Any relatives?"],
		["Puff", "One Puff. Fluff. Rustle, rustle, alone. Always."],
		["Ma", "Okay, okay, let's look around for your guardian, Puff.
		Fluffs should be sticking together, in large groups. To keep each other safe, you know?"],
		["Puff", "Fwaa, click! Click, click!"],
		["Ma", "Hm? I guess, I can always take more photos, but we need to find your guardian first!"],
		["Ma", "Can you lead the way, Puff? Let's find your guardian together, I can take more photos for you then."]
	],
	
	# for endings, all start at end_0. present a choice when all mementos have been collected
	"end_0": [
		end_cutscene_0,
		["Puff", "Ma? Are you here?"],
		["Puff", "It's so cold...We must be quite far away from Earth now."],
		["Puff", "That star is so bright... Is she over there? Ma, it's Puff, we came looking for you!"]
	],
	"end_1": [
		end_cutscene_1,
		["Puff", "I guess, Ma isn't here, either..."],
		["Puff", "Gotta keep searching for Ma. She must be cold out here, too."],
		["Puff", "Ma? Are you this way instead? Please answer Puff!"],
		["Puff", "Puff feels lonely... Puff misses Ma...
		Please come home, Ma. The Milky Way is too cold for Puff."]
	],
	"end_finale": [
		finale_cutscene,
		["Puff", "At this rate, Puff may never find Ma...
		But Puff has to keep going. Puff must know what happened to Ma."],
		["Puff", "Brr... Ma, are you here? Or did you leave the Milky Way, already?"],
		["Puff", "Where could Ma be...?"]
	],
	"choice": [
		choice_cutscene,
		["Puff", "Ma, is that you...? Can you hear Puff?"],
		["Puff", "You've become such a bright star, Ma.
		Just like the thousands of beautiful stars we can see from Earth."],
		["Puff", "Puff visited many stars in the Milky Way on the way here!
		None of them shined as bright as you do. Why is that?"],
		["Puff", "Of course, you must've worked hard to become such a bright star.
		It's always been your dream, Ma."],
		["Puff", "A friendly merchant had a few of your things. Did you leave them for Puff to find?
		Maybe you knew Puff would come, so you left behind all sorts of items as hints for us."],
		["Puff", "That's kind of you, Ma. Puff wouldn't have found you if it weren't for those items."],
		["Puff", "See, Puff collected so many stars to find you.
		The Milky Way was such a lovely experience. No matter where we went, the twinkling stars were there to greet us."],
		["Puff", "Mmm, yes, Puff is also happy we found you in the end.
		Everything about this exploration was well worth it."],
		["Puff", "Now then, as beautiful as she is, Ma certainly cannot return to Earth in this form.
		What should Puff do..."]
	],
	"choice_1": [
		choice_1_cutscene,
		["Puff", "Thank you for everything, Ma."],
		["Puff", "You've taught Puff so much, gave Puff the warmth of love..."],
		["Puff", "Earth was a wonderful experience, Ma."],
		["Puff", "Now you're fulfilling your dream, becoming a bright star in the Milky Way."],
		["Puff", "Please, allow Puff to help you. So that you can shine brighter with Puff's support."],
		["Puff", "The journey was long and cold, but it was all worth seeing you again, Ma."],
		["Puff", "Don't worry. Puff will be alright.
		It's Puff's turn to help you, after all."],
		["Puff", "And besides, Puff was just thinking how beautiful it must be to become a star as bright as you."],
		["Puff", "So, let's reach your dream together. Let's become just like the shining stars in the clear night sky."]
	],
	"choice_1_finale": [
		finale_cutscene,
		["Puff", "It's warm. We have become a bright, warm star."],
		["Puff", "Ma chose this path as a human, on her own volition.
		A beautiful path, one that Puff would be destined to follow.
		After all, every Fluff follows this path at the end of their lifetime."],
		["Puff", "Now, it's Puff's turn to teach Ma new things. To teach Ma how to become a star."],
		["Puff", "Together, we will light up the dark sky.
		We'll shine even brighter than any star we could ever dream of becoming."],
		["Puff", "Ma, I wonder... Do you think anyone can see us, down on Earth?"],
		["Puff", "I'm sure they can. May our bright light guide them, wherever they may go."]
	],
	"choice_2": [
		choice_2_cutscene,
		["Puff", "Puff will be going now, Ma."],
		["Puff", "As beautiful as you are, as pretty as all the Milkyay is...Puff wants to return to Earth."],
		["Puff", "Puff is glad we got to see each other once more, Ma."],
		["Puff", "It was a long journey, but Puff knows the way back, so don't worry"],
		["Puff", "Thank you for teaching Puff so many things. Thank you for taking care of Puff until now."],
		["Puff", "We may not have been able to find the other Fluffs that day...
		But you took Puff in, and treated us like your own human child."],
		["Puff", "Thanks to you, Puff got to learn so much. 
		We experienced the beauty of the world, the warmth of love, without even meeting another Fluff."],
		["Puff", "Puff might visit again one day. So don't disappear, okay? Promise."],
		["Puff", "By then, Puff will have experience so much more of the Earth. Puff will bring so many memories, so many stories to tell you, Ma."],
		["Puff", "It'll be Puff's turn to teach you new things."],
		["Puff", "So, Puff is thankful for everything you've given us.
		See you later, Ma."]
	],
	"choice_2_finale": [
		finale_cutscene,
		["Puff", "It's cold. Puff will definitely miss you, Ma."],
		["Puff", "But, Puff can't rely on Ma forever. Eventually, we would split to go our own ways."],
		["Puff", "The path you chose was beautiful, Ma.
		It's just not the path Puff will follow. Not yet, at least.
		After all, Puff wants to try living on Earth a little longer."],
		["Puff", "We aren't afraid. Puff knows we can look up to the night sky whenever we miss you, Ma."],
		["Puff", "Ma, we will meet again one day. So don't be sad.
		Keep shining brightly, and be the light in the clear night sky you've always dreamed of becoming."],
		["Puff", "May your bright light guide everyone, wherever we may go."]
	]
}
