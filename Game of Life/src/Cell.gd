extends Node2D

var state = false


func _on_Button_pressed():
	# Change the cell state
	state = not state
	
	# Change the Button icon
	var r 
	if state :
		r = load("res://assets/living.png")
	else :
		r = load("res://assets/dead.png")
	$Sprite.texture = r


func set_state(_state):
	# Change the cell state
	state = _state
	
	# Change the Button icon
	var r 
	if state :
		r = load("res://assets/living.png")
	else :
		r = load("res://assets/dead.png")
	$Sprite.texture = r


func get_state():
	return state
