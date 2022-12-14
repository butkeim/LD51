extends Node2D

onready var _probe := $Probe
onready var _shooter: Node2D = $Shooter
onready var _hitbox: Area2D = $Polygon2D/Area2D
onready var armor: Node2D = $Armor

var targets = [Vector2(-200, -100), Vector2(-200, 100), Vector2(200, 100), Vector2(200, -100)]
var current_target_index = 0

var dead_explosion = preload("res://scenes/fx/explosion/explosion_ship.tscn")

func _ready() -> void:
	name = "triangle"
	_probe.velocity_factor = 250
	armor.connect("no_armor", self, "_on_no_armor")
	_hitbox.connect("body_entered", self, "_on_body_entered")
	$Timer.connect("timeout", self, "_on_timer_timeout")
	$TimerShooter.connect("timeout", self, "_on_timer_shooter_timeout")
	
	_probe.connect("target_reached", self, "_on_target_reached")
	_probe.set_target(targets[current_target_index])

func _process(delta: float) -> void:
	$Polygon2D.position = _probe.position
	$Polygon2D.rotation = _probe.rotation
	
func _on_target_reached():
	current_target_index += 1
	if current_target_index > 3:
		current_target_index = 0
	_probe.set_target(targets[current_target_index])
	_probe.stop()
	$TimerShooter.start()
	$Timer.start()

func _on_timer_timeout():
	$TimerShooter.stop()
	_probe.start()

func _on_timer_shooter_timeout():
	_shooter.buck_shoot_laser_to(owner, _probe.position, Vector2.ZERO, 8000, 7)
	
func _on_body_entered(body: Node):
	body.delete()
	armor.take_damage(10)
	
func _on_no_armor():
	var effect = dead_explosion.instance()
	effect.position = _probe.global_position
	effect.get_child(0).emitting = true
	effect.scale = Vector2(1.3, 1.3)
	get_tree().root.add_child(effect)
	queue_free()
