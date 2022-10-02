extends Node2D
signal Send_Troop(speed,shoot_frequency,shoot_range)


func _ready():
	var usine = $Usine/containerGride/GrilleDisplay
	usine.connect("Send_Troop",self,"_on_Send_Troop")
	#OS.current_screen = 1
	#OS.window_fullscreen = true
	#OS.window_borderless = true
	
	pass


func _process(delta):

	if Input.is_action_just_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen

	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()

func _on_Send_Troop(speed,shoot_frequency,shoot_range):
	$Node2D.add_defender(speed,shoot_frequency,shoot_range)
	pass
