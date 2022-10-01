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
	print($TapisTile4.type)
	print($TapisTile3.type)
	print($TapisTile2.type)
	print($TapisTile.type)
	$TapisTile4.type = $TapisTile3.type
	$TapisTile4.AfficheType($TapisTile4.type)
	
	$TapisTile3.type = $TapisTile2.type
	$TapisTile3.AfficheType($TapisTile3.type)
	
	$TapisTile2.type = $TapisTile.type
	$TapisTile2.AfficheType($TapisTile.type)
	
	$TapisTile.InitialiserType()

	print($TapisTile4.type)
	print($TapisTile3.type)
	print($TapisTile2.type)
	print($TapisTile.type)

 
