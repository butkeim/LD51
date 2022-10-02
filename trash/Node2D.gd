tool
extends MultiMeshInstance2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distrib := false setget _distrib
onready var _m = $Explosion1

# Called when the node enters the scene tree for the first time.
func _ready():
	_distrib(true)

func _distrib(value):
	if value:
		multimesh.mesh = _m.mesh
		var s = 0.25
		for i in multimesh.instance_count:
			var v = Vector2(randf() * (525/s), randf() * (525/s))
			var t = Transform2D(0.0, v).scaled(Vector2(s, s))
			multimesh.set_instance_transform_2d(i, t)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
