extends Node2D

onready var _probe := $Probe

var targets = [Vector2(-230, -100), Vector2(-210, 100), Vector2(200, -100)]
var current_target_index = 0

func _ready() -> void:
	$Timer.connect("timeout", self, "_on_timer_timeout")
	_probe.connect("target_reached", self, "_on_target_reached")
	_probe.set_target(targets[current_target_index])

func _process(delta: float) -> void:
	$Polygon2D.position = _probe.position
	$Polygon2D.rotation = _probe.rotation
	
func _on_target_reached():
	current_target_index += 1
	if current_target_index > 2:
		current_target_index = 0
	_probe.set_target(targets[current_target_index])
	_probe.stop()
	$Timer.start()

func _on_timer_timeout():
	_probe.start()
