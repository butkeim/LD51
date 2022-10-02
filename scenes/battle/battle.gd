extends Node

var bomber_scene = preload("res://scenes/battle/triangle_enemy/triangle_enemy.tscn")
var hunter_scene = preload("res://scenes/battle/hunter/hunter.tscn")
var defender_scene = preload("res://scenes/battle/defender/defender.tscn")

onready var timer_new_defender: Timer = $TimerNewDefender
onready var timer_new_hunter: Timer = $TimerNewHunter

var hunter_spaws = [Vector2(-300, 30), Vector2(300, -30), Vector2(30, 300)]

func _ready() -> void:
	timer_new_defender.connect("timeout", self, "_on_new_defender_timeout")
	timer_new_hunter.connect("timeout", self, "_on_new_hunter_timeout")

func add_defender(speed: float, shoot_frequency: float, shoot_range: float):
	var new_defender = defender_scene.instance()
	new_defender.velocity_factor = speed
	new_defender.shoot_cadence = shoot_frequency
	new_defender.shooting_range = shoot_range
	add_child(new_defender)
	new_defender._probe.position = Vector2(0, 30)
	new_defender.set_owner(self)

func add_hunter(dash_frequency: float):
	var new_hunter = hunter_scene.instance()
	new_hunter.dash_frequency = dash_frequency
	add_child(new_hunter)
	new_hunter._probe.position = hunter_spaws[randi() % hunter_spaws.size()]
	new_hunter.set_owner(self)

func _on_new_defender_timeout():
	add_defender(70, 0.8, 200)
	
func _on_new_hunter_timeout():
	add_hunter(randf() * 20)

