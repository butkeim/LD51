extends KinematicBody2D

onready var polygon_2d: Polygon2D = $Polygon2D

var direction: Vector2
var speed: float
var friendly: bool = false
var explosion = preload("res://scenes/fx/explosion/explosion.tscn")

func _ready():
	name = "laser"
	if friendly:
		polygon_2d.color = Color(0.14, 0.42, 0.79, 1)

func _physics_process(delta: float) -> void:
	rotation = direction.angle() + PI / 2
	move_and_slide(direction * delta * speed)
	
func delete():
	var effect = explosion.instance()
	effect.scale = Vector2(0.5, 0.5)
	effect.position = global_position
	effect.get_child(0).emitting = true
	get_tree().root.add_child(effect)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
