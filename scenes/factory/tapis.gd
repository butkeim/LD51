extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vide
 
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func deplacer():
	$FactoryTile2.type = $FactoryTile.type
	$FactoryTile3.type = $FactoryTile2.type
