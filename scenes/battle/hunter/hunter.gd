extends Node

export var dash_frequency = 3.0

onready var area_2d: Area2D = $Area2D
onready var probe: KinematicBody2D = $Probe
onready var polygon_2d: Polygon2D = $Polygon2D
onready var timer_dash: Timer = $TimerDash

var target: Node2D

func _ready() -> void:
	timer_dash.wait_time = dash_frequency
	timer_dash.connect("timeout", self, "_on_timerdash_timeout")
	probe.connect("target_reached", self ,"_on_target_reached")
	probe.velocity_factor = 30
	
	area_2d.connect("area_entered", self, "_on_area_entered")

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
	pass

func _on_target_reached():
	probe.velocity_factor = 10.0
	pass
