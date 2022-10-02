extends Node

export var dash_frequency = 3.0
export var beam_schrink_speed = 5.0
export var beam_width = 6.0

onready var area_2d: Area2D = $Area2D
onready var _probe: KinematicBody2D = $Probe
onready var polygon_2d: Polygon2D = $Polygon2D
onready var timer_dash: Timer = $TimerDash
onready var beam: Line2D = $Beam
onready var area_2_d_2: Area2D = $Polygon2D/Area2D2
onready var armor: Node2D = $Armor

var explosion = preload("res://scenes/fx/explosion/explosion.tscn")
var dead_explosion = preload("res://scenes/fx/explosion/explosion_ship.tscn")

var all_targets = []
var target: Node2D

func _ready() -> void:
	randomize()
	name = "hunter"
	area_2_d_2.connect("body_entered", self, "_on_kinematic_body_2d_entered")
	timer_dash.connect("timeout", self, "_on_timerdash_timeout")
	_probe.connect("target_reached", self ,"_on_target_reached")
	_probe.connect("shoot_range_entered", self, "_on_shoot_range_entered")
	area_2d.connect("area_entered", self, "_on_area_entered")
	armor.connect("no_armor", self, "_on_no_armor")
	
	_probe.velocity_factor = 30.0
	_probe.shoot_range = 70.0
	
	timer_dash.wait_time = dash_frequency

func _process(delta: float) -> void:
	beam_width_effect(delta)

func _physics_process(delta: float) -> void:
	if !is_instance_valid(target):
		set_next_target()
		return
	polygon_2d.position = _probe.position
	polygon_2d.rotation = _probe.rotation
	_probe.set_target(target.position)

func set_prob_pos(position: Vector2):
	_probe.position = position
	polygon_2d.position = _probe.position
	polygon_2d.rotation = _probe.rotation

func _on_area_entered(body: Area2D):
	if !is_instance_valid(target):
		target = body.owner._probe

func _on_timerdash_timeout():
	_probe.velocity_factor = 400.0

func _on_target_reached():
	_probe.velocity_factor = 10.0
	
func _on_shoot_range_entered():
	if !is_instance_valid(target):
		return
	beam.points = [_probe.position, target.position]
	beam.visible = true
	beam.width = beam_width
	target.owner.armor.take_damage(40)
	var effect = explosion.instance()
	effect.position = target.global_position
	effect.get_child(0).emitting = true
	get_tree().root.add_child(effect)

func _on_kinematic_body_2d_entered(body: Node):
	body.delete()
	armor.take_damage(10)

func _on_no_armor():
	var effect = dead_explosion.instance()
	effect.position = _probe.global_position
	effect.get_child(0).emitting = true
	get_tree().root.add_child(effect)
	queue_free()

func beam_width_effect(delta):
	if !beam.visible:
		return
	beam.width -= beam_schrink_speed * delta
	if beam.width < 1.0:
		beam.visible = false

func set_next_target():
	if all_targets.size() == 0:
		return
	var index = randi() % all_targets.size()
	if is_instance_valid(all_targets[index]):
		target = all_targets[index]._probe
		all_targets.remove(index)

func add_available_target(target: Node2D):
	all_targets.append(target)
