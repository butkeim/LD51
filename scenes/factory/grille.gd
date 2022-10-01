extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# var a = 2
# var b = "text"
var tile = preload("res://scenes/factory/tile/factory_tile.tscn")
var childeInstance

# Called when the node enters the scene tree for the first time.
func _ready():
		for i in 12:
			for j in 8:
				childeInstance = tile.instance()
				childeInstance.position = Vector2(64*(j),64*(i))
				add_child(childeInstance)
				
pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
