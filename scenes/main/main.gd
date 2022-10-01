extends Node2D


func _ready():
	#OS.current_screen = 1
	#OS.window_fullscreen = true
	#OS.window_borderless = true
	
	pass


func _process(delta):

	if Input.is_action_just_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen

	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()
