extends Node2D

onready var _probe: KinematicBody2D = $Probe
onready var _polygon_2d: Polygon2D = $Polygon2D
onready var area_2d: Area2D = $Polygon2D/Area2D
onready var shoot_frequency: Timer = $ShootFrequency
onready var shooter: Node2D = $Shooter

var target: Node2D

func _ready() -> void:
	name = "defender"
	shoot_frequency.connect("timeout", self, "_on_shoot_frequency_timeout")
	area_2d.connect("body_entered", self, "_on_body_entered")
	_probe.connect("shoot_range_entered", self, "_on_shoot_range_entered")
	_probe.connect("shoot_range_exited", self, "_on_shoot_range_exited")
	_probe.velocity_factor = 70.0
	_probe.reached_target_distance = 50.0
	_probe.set_target(Vector2(-100 + (randi() % 200) , -100 + (randi() % 200)))
	_probe.shoot_range = 200.0
	_probe.start()

func _process(delta: float) -> void:
	_polygon_2d.position = _probe.position
	_polygon_2d.rotation = _probe.rotation
	if target == null:
		return
	_probe.set_target(target._probe.position)

func _on_body_entered(body: Node):
	if body.owner != null and body.owner.name == "triangle":
		target = body.owner
		_probe.set_target(body.position)
		print("bodyentered")

func _on_shoot_range_entered():
	shoot_frequency.start()
	pass

func _on_shoot_range_exited():
	shoot_frequency.stop()
	pass

func _on_shoot_frequency_timeout():
	shooter.shoot_laser_to(owner, _probe.position, _probe._current_target, 15000.0, 6)
