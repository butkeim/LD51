extends KinematicBody2D

var direction: Vector2
var speed: float

func _physics_process(delta: float) -> void:
	rotation = direction.angle() + PI / 2
	move_and_slide(direction * delta * speed)
