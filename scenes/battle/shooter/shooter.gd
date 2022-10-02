extends Node2D

var laser = preload("res://scenes/battle/shooter/laser/laser.tscn")
export var friendly = false

func enable_bit(mask: int, index: int) -> int:
	return mask | (1 << index)

func disable_bit(mask: int, index: int) -> int:
	return mask & ~(1 << index)

func get_shoot_rand(precision: float):
	return (-0.5 + randf()) * precision

func get_shoot_vec_rand(precision: float, vec: Vector2):
	return Vector2(vec.x + get_shoot_rand(precision), vec.y + get_shoot_rand(precision))

func shoot_laser_to(battle: Node2D, from: Vector2, to: Vector2, speed: float, precision: float):
	var projectile = laser.instance()
	projectile.position = Vector2(from.x + get_shoot_rand(precision), from.y + get_shoot_rand(precision))
	projectile.speed = speed
	projectile.friendly = true
	
	if friendly:
		projectile.collision_layer = disable_bit(projectile.collision_layer, 2)
		projectile.collision_layer = enable_bit(projectile.collision_layer, 3)
		
	projectile.direction = from.direction_to(Vector2(to.x + get_shoot_rand(precision), to.y + get_shoot_rand(precision)))
	battle.add_child(projectile)

func buck_shoot_laser_to(battle: Node2D, from: Vector2, to: Vector2, speed: float, buck_number: int):
	for i in range(buck_number):
		var projectile = laser.instance()
		projectile.position = get_shoot_vec_rand(20, from)
		projectile.speed = speed + (-500 + randi() % 1000)
		projectile.direction = from.direction_to(get_shoot_vec_rand(20, to))

		battle.add_child(projectile)
		
