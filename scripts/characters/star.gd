extends Area2D

func _input_event(_viewport, event, _dx):
	if event.is_action_pressed("leftclick"):
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		get_parent().queue_free()

func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
