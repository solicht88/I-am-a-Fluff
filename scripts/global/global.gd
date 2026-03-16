extends Node

var transition_node = preload("res://scenes/transition_animation.tscn")

func fade_out():
	var transition = transition_node.instantiate()
	transition.get_node("ColorRect").color.a = 255
	add_child(transition)
	
	var player = $transition_animation/transition_player
	#print("fade out")
	player.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	#await player.animation_finished
	transition.queue_free()


func fade_in():
	var transition = transition_node.instantiate()
	transition.get_node("ColorRect").color.a = 0
	add_child(transition)
	
	var player = $transition_animation/transition_player
	#print("fade in")
	player.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	transition.queue_free()
