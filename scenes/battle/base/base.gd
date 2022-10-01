extends Node2D


onready var _area2D: Area2D = $Area2D


func _ready() -> void:
	_area2D.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	body.delete()
