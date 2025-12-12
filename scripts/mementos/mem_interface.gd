extends Control

@onready var exit_btn := $exit as Button
@onready var left_btn := $left_btn as Button
@onready var right_btn := $right_btn as Button

@onready var btns = [exit_btn, left_btn, right_btn]
@onready var panels = [$dust, $ribbon, $lotus, $candle, $photo]

@onready var mem_name := $name as Label
@onready var mem_desc := $desc as Label

var small_size = Vector2(180, 180)
var small_img_scale = Vector2(0.175, 0.175)
var large_size = Vector2(300, 300)
var large_img_scale = Vector2(0.292, 0.292)

# adjustment variables for changing from small to large circle
var adj_size = Vector2(120.0/133.0, 120.0/133.0) # (300-180)/133 = ~0.9
var adj_scale = Vector2(0.117/133.0, 0.117/133.0) # (0.292-0.175)/133 = ~0.00088
var adj_y = 60.0/133.0 # (220-160)/133 = ~0.45

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

var child_mods_c = [
	Color8(150, 150, 150, 255),
	Color8(200, 200, 200, 255),
	Color8(255, 255, 255, 255),
	Color8(200, 200, 200, 255),
	Color8(150, 150, 150, 255)
]

var save_data = Save.save_data
var inv = Save.save_data.inventory
var mem_data = Data.mem_data


func _disable_btns(btns):
	for btn in btns:
		btn.disabled = true
		btn.set_default_cursor_shape(Control.CURSOR_ARROW)

func _enable_btns(btns):
	for btn in btns:
		btn.disabled = false
		btn.set_default_cursor_shape(Control.CURSOR_POINTING_HAND)

func _update_mem_display(cur_mem):
	if not save_data.inventory[cur_mem]:
		cur_mem = "unknown"
		#pass
	mem_name.text = mem_data[cur_mem][0]
	mem_desc.text = mem_data[cur_mem][1]

func _update_mem_mods(panels):
	for i in range(len(panels)):
		var mem = panels[i]
		if inv[mem.name]:
			mem.get_child(0).self_modulate = child_mods_c[i]


# Called when the node enters the scene tree for the first time.
func _ready():
	await ready
	_update_mem_display(panels[2].name)
	_update_mem_mods(panels)
	Global.fade_out()
	#print(child_mods_c[1])
	_update_mem_mods(panels)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	Global.fade_in()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_left_btn_pressed():
	var new_panels = panels.duplicate(true)
	
	_disable_btns(btns)
	
	for i in range(267/2):
		for panel in range(len(panels)):
			var cur_panel = panels[panel]
			var panel_img = cur_panel.get_child(0)
			
			cur_panel.position.x += 2
			cur_panel.self_modulate.a += (mods_a[(panel+1) % 5] - mods_a[panel]) / 255.0 / 133.0
			
			if inv[cur_panel.name]:
				panel_img.self_modulate.r += (child_mods_c[(panel+1) % 5].r8 - child_mods_c[panel].r8) / 255.0 / 133.0
				panel_img.self_modulate.g += (child_mods_c[(panel+1) % 5].g8 - child_mods_c[panel].g8) / 255.0 / 133.0
				panel_img.self_modulate.b += (child_mods_c[(panel+1) % 5].b8 - child_mods_c[panel].b8) / 255.0 / 133.0
			
			if panel == 2:
				# make previous center circle smaller
				cur_panel.size -= adj_size
				panel_img.scale -= adj_scale
				# gradually adjust position values
				cur_panel.position.x += 388.0/133.0 - 2
				cur_panel.position.y += adj_y
			
			if panel == 1:
				# make oncoming center circle larger
				cur_panel.size += adj_size
				panel_img.scale += adj_scale
				# gradually adjut y value
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
		var cur_panel = panels[i]
		var panel_img = cur_panel.get_child(0)
		
		cur_panel.position = positions[i]
		cur_panel.self_modulate = mods_c[i]
		
		if inv[cur_panel.name]:
			panel_img.self_modulate = child_mods_c[i]
		
		if i == 2:
			cur_panel.size = large_size
			panel_img.scale = large_img_scale
		else:
			cur_panel.size = small_size
			panel_img.scale = small_img_scale
	
	_update_mem_display(panels[2].name)
	
	_enable_btns(btns)


func _on_right_btn_pressed():
	#var cur_focus = panels[2]
	#var cur_focus_img = cur_focus.get_child(0)
	
	var new_panels = panels.duplicate(true)
	
	_disable_btns(btns)
	
	''' old, simpler animation code
	panels[2].size = small_size
	panels[2].position.y = 220
	panels[2].get_child(0).scale = small_img_scale
	cur_focus.position = Vector2(550, 220)
	'''
	
	for i in range(267/2):
		for panel in range(len(panels)):
			var cur_panel = panels[panel]
			var panel_img = cur_panel.get_child(0)
			
			cur_panel.position.x -= 2
			cur_panel.self_modulate.a += (mods_a[(panel-1) % 5] - mods_a[panel]) / 255.0 / 133.0
			
			if inv[cur_panel.name]:
				panel_img.self_modulate.r += (child_mods_c[(panel-1) % 5].r8 - child_mods_c[panel].r8) / 255.0 / 133.0
				panel_img.self_modulate.g += (child_mods_c[(panel-1) % 5].g8 - child_mods_c[panel].g8) / 255.0 / 133.0
				panel_img.self_modulate.b += (child_mods_c[(panel-1) % 5].b8 - child_mods_c[panel].b8) / 255.0 / 133.0
			
			if panel == 2:
				#print(panel_img.self_modulate)
				pass
			
			if panel == 2:
				# make previous center circle smaller
				cur_panel.size -= adj_size
				panel_img.scale -= adj_scale
				# gradually adjust y value
				cur_panel.position.y += adj_y
			
			if panel == 3:
				# make oncoming center circle larger
				cur_panel.size += adj_size
				panel_img.scale += adj_scale
				# gradually adjust position values
				cur_panel.position.x -= 388.0/133.0 - 2 # (878-490)/133 - 2 = ~0.92
				cur_panel.position.y -= adj_y
			
			# move panel to the other edge of screen after leaving the screen
			if cur_panel.position.x <= -180:
				new_panels.remove_at(panel)
				new_panels.append(panels[panel])
				cur_panel.position = Vector2(1280, 220)
		
		await get_tree().create_timer(0.001).timeout
	
	panels = new_panels
	
	# correct position & size & scale of circles at end of animation
	for i in range(len(panels)):
		var cur_panel = panels[i]
		var panel_img = cur_panel.get_child(0)
		
		cur_panel.position = positions[i]
		cur_panel.self_modulate = mods_c[i]
		
		if inv[cur_panel.name]:
			panel_img.self_modulate = child_mods_c[i]
		
		if i == 2:
			panels[i].size = large_size
			panel_img.scale = large_img_scale
		else:
			panels[i].size = small_size
			panel_img.scale = small_img_scale
	
	''' old animation code
	var next_focus = panels[2]
	var next_focus_img = next_focus.get_child(0)
	next_focus.size = large_size
	next_focus_img.scale = large_img_scale
	'''
	
	_update_mem_display(panels[2].name)
	
	_enable_btns(btns)
