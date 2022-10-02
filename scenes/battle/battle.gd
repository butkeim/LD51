extends Node

var bomber_scene = preload("res://scenes/battle/triangle_enemy/triangle_enemy.tscn")
var hunter_scene = preload("res://scenes/battle/hunter/hunter.tscn")
var defender_scene = preload("res://scenes/battle/defender/defender.tscn")

onready var timer_new_defender: Timer = $TimerNewDefender



func _ready() -> void:
	timer_new_defender.connect("timeout", self, "_on_new_defender_timeout")

func add_defender(speed: float, shoot_frequency: float, shoot_range: float):
	var new_defender = defender_scene.instance()
	new_defender.velocity_factor = speed
	new_defender.shoot_cadence = shoot_frequency
	new_defender.shooting_range = shoot_range
	add_child(new_defender)
	new_defender._probe.position = Vector2(0, 30)
	new_defender.set_owner(self)


func _on_new_defender_timeout():
	add_defender(70, 0.8, 200)
