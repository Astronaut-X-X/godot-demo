extends Node2D

export (PackedScene) var cell_scene

# var height = 584 / 8
var height =  584  / 8
# var width = 1008 / 8
var width = 1008 / 8

var p_state = false
var t 

func _ready():
	for i in range(height):
		for j in range(width):
			var cell = cell_scene.instance()
			cell.position = Vector2((j+1)*8,(i+1)*8)
			add_child(cell)
	
	var c = $Control
	remove_child(c)
	add_child(c)
	t = $Timer
	remove_child(t)
	add_child(t)


func _on_Button_pressed():
	# Stop the process.
	p_state = not p_state
	
	# Change the Button icon
	var r 
	if p_state :
		r = load("res://assets/icon/poweron.png")
		t.start()
	else :
		r = load("res://assets/icon/poweroff.png")
		t.stop()
	$Control/Button.icon = r


func check_is_alive(i , state):
	var count = 0
	
	if i == 0:
		if get_child(i+1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
		if get_child(i+width+1).get_state():
			count += 1
			
	elif i == width-1:
		if get_child(i-1).get_state():
			count += 1
		if get_child(i+width-1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
			
	elif i == (height-1) * width:
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-width+1).get_state():
			count += 1
		if get_child(i+1).get_state():
			count += 1
		
	elif i == height * width - 1:
		if get_child(i-width-1).get_state():
			count += 1
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-1).get_state():
			count += 1
			
	elif i < width:
		if get_child(i-1).get_state():
			count += 1
		if get_child(i+1).get_state():
			count += 1
		if get_child(i+width-1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
		if get_child(i+width+1).get_state():
			count += 1
		
	elif i > (height-1) * width and i < height * width:
		if get_child(i-width-1).get_state():
			count += 1
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-width+1).get_state():
			count += 1
		if get_child(i-1).get_state():
			count += 1
		if get_child(i+1).get_state():
			count += 1
	
	elif i % width == 0:
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-width+1).get_state():
			count += 1
		if get_child(i+1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
		if get_child(i+width+1).get_state():
			count += 1
		
	elif i % width == width-1:
		if get_child(i-width-1).get_state():
			count += 1
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-1).get_state():
			count += 1
		if get_child(i+width-1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
			
	else:
		if get_child(i-width-1).get_state():
			count += 1
		if get_child(i-width).get_state():
			count += 1
		if get_child(i-width+1).get_state():
			count += 1
		if get_child(i+1).get_state():
			count += 1
		if get_child(i-1).get_state():
			count += 1
		if get_child(i+width-1).get_state():
			count += 1
		if get_child(i+width).get_state():
			count += 1
		if get_child(i+width+1).get_state():
			count += 1
	
	if count == 2:
		return state
	if count == 3:
		return true
	return false


func _on_Timer_timeout():
	var temp_state = []
	if p_state :
		for i in range (width*height):
			temp_state.append(check_is_alive(i, get_child(i).get_state()))
		for i in range (width*height):
			get_child(i).set_state(temp_state[i])
