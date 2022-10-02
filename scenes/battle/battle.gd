extends Node

var bomber_scene = preload("res://scenes/battle/triangle_enemy/triangle_enemy.tscn")
var hunter_scene = preload("res://scenes/battle/hunter/hunter.tscn")
var defender_scene = preload("res://scenes/battle/defender/defender.tscn")

onready var timer_new_defender: Timer = $TimerNewDefender
onready var timer_new_hunter: Timer = $TimerNewHunter
onready var timer_new_bomber: Timer = $TimerNewBomber

var hunter_spaws = [Vector2(-300, 30), Vector2(300, -30), Vector2(30, 300)]

var hunters = []
var defenders = []
var bombers = []

func _ready() -> void:
	randomize()
	timer_new_defender.connect("timeout", self, "_on_new_defender_timeout")
	timer_new_hunter.connect("timeout", self, "_on_new_hunter_timeout")
	timer_new_bomber.connect("timeout", self, "_on_new_bomber_timeout")

func _process(delta: float) -> void:
	cleanup(hunters)
	cleanup(defenders)
	cleanup(bombers)

func cleanup(tab):
	var index_to_remove = []
	var index = 0
	for item in tab:
		if !is_instance_valid(item):
			index_to_remove.append(index)
		index += 1
	for to_remove in index_to_remove:
		tab.remove(to_remove)

func add_defender(speed: float, shoot_frequency: float, shoot_range: float):
	var new_defender = defender_scene.instance()
	new_defender.velocity_factor = speed
	new_defender.shoot_cadence = shoot_frequency
	new_defender.shooting_range = shoot_range
	add_child(new_defender)
	new_defender._probe.position = Vector2(0, 30)
	new_defender.set_owner(self)
	
	new_defender.all_targets.append_array(hunters)
	new_defender.all_targets.append_array(bombers)
	for hunter in hunters:
		hunter.all_targets.append(new_defender)
	defenders.append(new_defender)
	

func add_hunter(dash_frequency: float):
	var new_hunter = hunter_scene.instance()
	new_hunter.dash_frequency = dash_frequency
	add_child(new_hunter)
	new_hunter._probe.position = Vector2(300, 0).rotated(deg2rad(rand_range(0, 360)))
	new_hunter.set_owner(self)
	
	new_hunter.all_targets.append_array(defenders)
	for defender in defenders:
		defender.all_targets.append(new_hunter)
	hunters.append(new_hunter)

func add_bomber():
	var new_bomber = bomber_scene.instance()
	add_child(new_bomber)
	new_bomber.set_owner(self)
	new_bomber._probe.position = Vector2(300, -300)
	for defender in defenders:
		defender.all_targets.append(new_bomber)
	bombers.append(new_bomber)

func _on_new_defender_timeout():
	add_defender(40 + randi() % 120, 0.8, 200)
	
func _on_new_hunter_timeout():
	add_hunter(randf() * 30)

func _on_new_bomber_timeout():
	add_bomber()
