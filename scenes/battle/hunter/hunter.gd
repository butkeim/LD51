extends Node

export var dash_frequency = 3.0
export var beam_schrink_speed = 5
export var beam_width = 6

onready var area_2d: Area2D = $Area2D
onready var probe: KinematicBody2D = $Probe
onready var polygon_2d: Polygon2D = $Polygon2D
onready var timer_dash: Timer = $TimerDash
onready var beam: Line2D = $Beam

var explosion = preload("res://scenes/fx/explosion/explosion.tscn")

var target: Node2D


func _ready() -> void:
	timer_dash.connect("timeout", self, "_on_timerdash_timeout")
	probe.connect("target_reached", self ,"_on_target_reached")
	probe.connect("shoot_range_entered", self, "_on_shoot_range_entered")
	area_2d.connect("area_entered", self, "_on_area_entered")
	
	probe.velocity_factor = 30.0
	probe.shoot_range = 70.0
	
	timer_dash.wait_time = dash_frequency

func _process(delta: float) -> void:
	beam_width_effect(delta)

func _physics_process(delta: float) -> void:
	if target == null:
		return
		
	polygon_2d.position = probe.position
	polygon_2d.rotation = probe.rotation
	probe.set_target(target.position)

func _on_area_entered(body: Area2D):
	target = body.owner._probe

func _on_timerdash_timeout():
	probe.velocity_factor = 400.0

func _on_target_reached():
	probe.velocity_factor = 10.0
	
func _on_shoot_range_entered():
	beam.points = [probe.position, target.position]
	beam.visible = true
	beam.width = beam_width
	var effect = explosion.instance()
	effect.position = target.global_position
	effect.get_child(0).emitting = true
	get_tree().root.add_child(effect)
	
func beam_width_effect(delta):
	if !beam.visible:
		return
	beam.width -= beam_schrink_speed * delta
	if beam.width < 1.0:
		beam.visible = false
