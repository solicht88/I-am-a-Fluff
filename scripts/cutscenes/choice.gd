extends Control

# signals when a choice has been made & connects to ending cutscenes
signal chosen_choice(key)


# Called when the node enters the scene tree for the first time.
func _ready():
	#chosen_choice.connect(_fade_out)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	self.visible = false


func _on_choice_1_pressed():
	chosen_choice.emit("choice_1")
	_fade_out()


func _on_choice_2_pressed():
	chosen_choice.emit("choice_2")
	_fade_out()
