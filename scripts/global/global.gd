extends Node

var transition_node = preload("res://scenes/transition_animation.tscn")

func fade_out():
	print("fading out")
	var transition = transition_node.instantiate()
	transition.get_node("ColorRect").color.a = 255
	add_child(transition)
	
	var player = $transition_animation/transition_player
	#print("fade out")
	player.play("fade_out")
	await player.animation_finished
	print("deleting fade...")
	transition.queue_free()


func fade_in():
	var transition = transition_node.instantiate()
	add_child(transition)
	transition.get_node("ColorRect").color.a = 0
	
	var player = $transition_animation/transition_player
	#print("fade in")
	player.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	transition.queue_free()
