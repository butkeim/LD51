extends Node2D

var laser = preload("res://scenes/battle/shooter/laser/laser.tscn")

func shoot_laser_to(battle: Node2D, from: Vector2, to: Vector2, speed: float):
	var projectile = laser.instance()
	projectile.position = from
	projectile.speed = speed
	projectile.direction = from.direction_to(to)
	battle.add_child(projectile)
	

