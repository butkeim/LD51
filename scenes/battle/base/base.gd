extends Node2D

signal annihilation

var dead_explosion = preload("res://scenes/fx/explosion/explosion_ship.tscn")

onready var _area2D: Area2D = $Area2D
onready var armor: Node2D = $Armor


func _ready() -> void:
	armor.connect("no_armor", self, "_on_no_armor")
	_area2D.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	body.delete()
	armor.take_damage(10)

func _on_no_armor():
	emit_signal("annihilation")
	var effect = dead_explosion.instance()
	effect.scale = Vector2(3, 3)
	effect.position = global_position
	effect.get_child(0).emitting = true
	get_tree().root.add_child(effect)
	queue_free()
