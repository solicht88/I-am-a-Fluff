extends Node

var transition_node = preload("res://scenes/transition_animation.tscn")
var transition = transition_node.instantiate()

func fade_out():
	add_child(transition)
	transition.get_node("ColorRect").color.a = 255
	
	var player = $transition_animation/transition_player
	player.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	transition.queue_free()


func fade_in():
	add_child(transition)
	transition.get_node("ColorRect").color.a = 0
	
	var player = $transition_animation/transition_player
	player.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	transition.queue_free()
