extends Node2D

onready var _probe: KinematicBody2D = $Probe
onready var _polygon_2d: Polygon2D = $Polygon2D
onready var area_2d: Area2D = $Polygon2D/Area2D

var target: Node2D

func _ready() -> void:
	name = "defender"
	area_2d.connect("body_entered", self, "_on_body_entered")
	_probe.velocity_factor = 70.0
	_probe.set_target(Vector2(-100 + (randi() % 200) , -100 + (randi() % 200)))
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
