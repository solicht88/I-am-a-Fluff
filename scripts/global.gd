extends Node

var transition_node = preload("res://scenes/transition_animation.tscn")

# format: [name, price, description]
var item_data: Dictionary = {
	"fuel": ["Fuel Stone", str(100*Save.save_data.price_mult) + " Stars", "Keep Puff warm while travelling the Milky Way"],
	"compass": ["Compass", str(200*Save.save_data.price_mult) + " Stars", "Helps Puff keep track of directions while exploring"]
}
