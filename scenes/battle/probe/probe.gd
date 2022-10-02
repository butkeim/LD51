extends KinematicBody2D

signal target_reached
signal shoot_range_entered
signal shoot_range_exited

var reached_target_distance := 40
var velocity_factor := 200.0
var steering_factor := 5.0
var shoot_range := 100.0

var _velocity := Vector2.ZERO
var _current_target: Vector2 = Vector2.INF
var _is_stopped := false
var _is_in_shoot_range: bool

func _process(delta: float) -> void:
	if _is_stopped or _current_target == Vector2.INF:
		return
	
	shoot_range_signal_launcher()
	target_reached_launcher()
	
	var direction := position.direction_to(_current_target)
	var desired_velocity := direction * (velocity_factor / 3)
	var steering := (desired_velocity - _velocity) * delta * steering_factor

	_velocity += steering
	_velocity = move_and_slide(_velocity * int(position.distance_to(_current_target) > reached_target_distance))
	rotation = _velocity.angle() + PI / 2

func target_reached_launcher():
	if position.distance_to(_current_target) < reached_target_distance:
		emit_signal("target_reached")

func shoot_range_signal_launcher():
	if !_is_in_shoot_range and position.distance_to(_current_target) < shoot_range:
		_is_in_shoot_range = true
		emit_signal("shoot_range_entered")
	elif _is_in_shoot_range and position.distance_to(_current_target) >= shoot_range:
		_is_in_shoot_range = false
		emit_signal("shoot_range_exited")

func has_target():
	return _current_target != Vector2.INF

func stop():
	_is_stopped = true

func start():
	_is_stopped = false

func set_target(target: Vector2):
	_current_target = target
