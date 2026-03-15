extends Control

# TODO: signal when a choice has been made & connect to ending cutscenes
signal chosen_choice(key)


# Called when the node enters the scene tree for the first time.
func _ready():
	#chosen_choice.connect($AnimationPlayer.play("fade_out"))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_choice_1_pressed():
	chosen_choice.emit("choice_1")


func _on_choice_2_pressed():
	chosen_choice.emit("choice_2")
