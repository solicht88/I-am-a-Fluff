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
	
	var mods_a = [
		100,
		130,
		160,
		130,
		100
	]
	
	var mods_c = [
		Color8(255, 255, 255, 100),
		Color8(255, 255, 255, 130),
		Color8(255, 255, 255, 160),
		Color8(255, 255, 255, 130),
		Color8(255, 255, 255, 100)
	]
	
	for btn in btns:
		btn.disabled = true
		btn.set_default_cursor_shape(Control.CURSOR_ARROW)
	
	''' old, simpler animation code
	panels[2].size = small_size
	panels[2].position.y = 220
	panels[2].get_child(0).scale = small_img_scale
	cur_focus.position = Vector2(550, 220)
	'''
	
	# adjustment variables for changing from small to large circle
	var adj_size = Vector2(120.0/133.0, 120.0/133.0) # (300-180)/133 = ~0.9
	var adj_scale = Vector2(0.117/133.0, 0.117/133.0) # (0.292-0.175)/133 = ~0.00088
	var adj_y = 60.0/133.0 # (220-160)/133 = ~0.45
	
	for i in range(267/2):
		for panel in range(len(panels)):
			var cur_panel = panels[panel]
			cur_panel.position.x += 2
			cur_panel.self_modulate.a += (mods_a[(panel+1) % 5] - mods_a[panel]) / 255.0 / 133.0
			
			if panel == 2:
				# make previous center circle smaller
				cur_panel.size -= adj_size
				cur_panel.get_child(0).scale -= adj_scale
				# gradually adjust y value
				cur_panel.position.x += 388.0/133.0 - 2 # (878-490)/133 - 2 = ~0.92
				cur_panel.position.y += adj_y
			
			if panel == 1:
				# make oncoming center circle larger
				cur_panel.size += adj_size
				cur_panel.get_child(0).scale += adj_scale
				# gradually adjut y value
				#cur_panel.position.x += 0
				cur_panel.position.y -= adj_y
			
			#panels[panel].position = positions[(panel+1) % 5]
			# move panel to the other edge of screen after leaving the screen
			if cur_panel.position.x >= 1280:
				new_panels.remove_at(panel)
				new_panels.push_front(panels[panel])
				cur_panel.position = Vector2(-180, 220)
				#print(cur_panel)
		await get_tree().create_timer(0.001).timeout
	
	panels = new_panels
	
	# correct position & size & scale of circles at end of animation
	for i in range(len(panels)):
		panels[i].position = positions[i]
		panels[i].self_modulate = mods_c[i]
		
		if i == 2:
			panels[i].size = large_size
			panels[i].get_child(0).scale = large_img_scale
		else:
			panels[i].size = small_size
			panels[i].get_child(0).scale = small_img_scale
	
	''' old animation code
	var next_focus = panels[2]
	var next_focus_img = next_focus.get_child(0)
	next_focus.size = large_size
	next_focus_img.scale = large_img_scale
	'''
	
	# TODO: change name + description text to match focus memento
	
	for btn in btns:
		btn.disabled = false
		btn.set_default_cursor_shape(Control.CURSOR_POINTING_HAND)
