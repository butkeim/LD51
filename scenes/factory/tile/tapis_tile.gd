extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func InitialiserType():
	type = rand_range(0,2)
	AfficheType(type)
	
	
func AfficheType(type:int):
	if (type == 1):
		$FactoryTapis.visible = true	
		$FactoryTile.visible  = false
	else:
		$FactoryTapis.visible = false	
		$FactoryTile.visible  = true
	
