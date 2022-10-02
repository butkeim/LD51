extends Node2D

export var velocity_factor: float = 70.0
export var shooting_range: float = 200.0
export var shoot_cadence: float = 1.0

onready var _probe: KinematicBody2D = $Probe
onready var _polygon_2d = $Polygon2D
onready var area_2d: Area2D = $Polygon2D/Area2D
onready var shoot_frequency: Timer = $ShootFrequency
onready var shooter: Node2D = $Shooter

var all_targets = []
var target: Node2D = null

func _ready() -> void:
	name = "defender"
	randomize()
	shoot_frequency.connect("timeout", self, "_on_shoot_frequency_timeout")
	area_2d.connect("body_entered", self, "_on_body_entered")
	shoot_frequency.wait_time = shoot_cadence
	_probe.connect("shoot_range_entered", self, "_on_shoot_range_entered")
	_probe.connect("shoot_range_exited", self, "_on_shoot_range_exited")
	_probe.velocity_factor = velocity_factor
	_probe.reached_target_distance = 50.0
	_probe.set_target(Vector2(-100 + (randi() % 200) , -100 + (randi() % 200)))
	_probe.shoot_range = shooting_range
	_probe.start()

func _process(delta: float) -> void:
	_polygon_2d.position = _probe.position
	_polygon_2d.rotation_degrees = _probe.rotation_degrees - 90
	if is_instance_valid(target):
		_probe.set_target(target._probe.position)
		return
	set_next_target()

func set_next_target():
	if !all_targets.empty():
		var index = randi() % all_targets.size()
		var next_target = all_targets[index]
		all_targets.remove(index)
		if !is_instance_valid(next_target):
			return
		target = next_target.owner
		_probe.set_target(next_target.position)

func _on_body_entered(body: Node):
	if body.owner != null and (body.owner.name == "hunter" or body.owner.name == "triangle"):
		all_targets.append(body)
	print(all_targets.size())

func _on_shoot_range_entered():
	shoot_frequency.start()
	pass

func _on_shoot_range_exited():
	shoot_frequency.stop()
	pass

func _on_shoot_frequency_timeout():
	shooter.shoot_laser_to(owner, _probe.position, _probe._current_target, 15000.0, 6)
