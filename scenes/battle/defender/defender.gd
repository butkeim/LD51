extends Node2D

onready var _probe: KinematicBody2D = $Probe
onready var _polygon_2d: Polygon2D = $Polygon2D

var target: Node2D

func _ready() -> void:
	_probe.velocity_factor = 70.0
	_probe.start()

func _process(delta: float) -> void:
	_probe.set_target(target._probe.position)
	_polygon_2d.position = _probe.position
	_polygon_2d.rotation = _probe.rotation
