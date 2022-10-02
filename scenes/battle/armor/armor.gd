extends Node2D

signal no_armor

export var state = 100.0

func take_damage(damage: float):
	state -= damage
	if state < 0:
		emit_signal("no_armor")
