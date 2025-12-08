extends Control

@onready var exit_btn = $exit
@onready var left_btn = $left_btn
@onready var right_btn = $right_btn

@onready var btns = [exit_btn, left_btn, right_btn]
@onready var panels = [$dust, $ribbon, $lotus, $candle, $photo]

# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	Global.fade_out()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_left_btn_pressed():
	pass


func _on_right_btn_pressed():
	var small_size = Vector2(180, 180)
	var small_img_scale = Vector2(0.175, 0.175)
	var large_size = Vector2(300, 300)
	var large_img_scale = Vector2(0.292, 0.292)
	
	#var cur_focus = panels[2]
	#var cur_focus_img = cur_focus.get_child(0)
	
	var new_panels = panels.duplicate(true)
	
	var positions = [
		Vector2(-45, 220),
		Vector2(222, 220),
		Vector2(490, 160),
		Vector2(878, 220),
		Vector2(1145, 220)
	]
	
	var modulates = [
		Color.hex(0xffffff64),
		Color.hex(0xffffff82),
		Color.hex(0xffffffa0),
		Color.hex(0xffffff82),
		Color.hex(0xffffff64)
	] 
	
	for btn in btns:
		btn.disabled = true
	
	panels[2].size = small_size
	panels[2].position.y = 220
	panels[2].get_child(0).scale = small_img_scale
	#cur_focus.position = Vector2(550, 220)
	
	# for leaving large circle: 328, all other circles can add 267/268
	# TODO: add list of goal positions for circles to move to
	# TODO: have circle on end reappear on other end
	# TODO: make circle size change gradual instead of instant
	# TODO: have self-modulate transparency change based on current circle order
	
	for i in range(267):
		for panel in range(len(panels)):
			'''
			if panel == cur_focus:
				panel.position.x += 2.4
			else:
				panel.position.x += 2
			'''
			var cur_panel = panels[panel]
			cur_panel.position.x += 1
			#panels[panel].position = positions[(panel+1) % 5]
			if cur_panel.position.x == 1280:
				new_panels.remove_at(panel)
				new_panels.push_front(panels[panel])
				cur_panel.position = Vector2(-180, 220)
				#print(cur_panel)
		await get_tree().create_timer(0.001).timeout
	
	panels = new_panels
	#print(panels)
	
	for i in range(len(panels)):
		panels[i].position = positions[i]
	
	
	var next_focus = panels[2]
	var next_focus_img = next_focus.get_child(0)
	next_focus.size = large_size
	next_focus_img.scale = large_img_scale
	
	
	for btn in btns:
		btn.disabled = false
