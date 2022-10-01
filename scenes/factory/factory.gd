extends Node2D
signal timer_tapis

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.

func _ready():

	
	
	$Timer.connect("timeout",self,"DeplaceTapis")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func DeplaceTapis():
	$Tapis.deplacer()
	$Tapis2.deplacer()
	$Tapis3.deplacer()
	$Tapis4.deplacer()
	$Tapis5.deplacer()
	$Tapis6.deplacer()
	$Tapis7.deplacer()
	$Tapis8.deplacer()
	$Tapis9.deplacer()
	$Tapis10.deplacer()
	$Tapis11.deplacer()
	$Tapis12.deplacer()
	
