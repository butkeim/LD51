extends KinematicBody2D

var direction: Vector2
var speed: float
var friendly: bool = false

func _ready():
	name = "laser"
	

func _physics_process(delta: float) -> void:
	rotation = direction.angle() + PI / 2
	move_and_slide(direction * delta * speed)
	
func delete():
	queue_free()
