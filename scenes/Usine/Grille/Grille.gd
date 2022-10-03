extends Resource
class_name Grille

signal objects_change(indexes)

func _process(delta: float) -> void:
	self.connect("mouse_entered",self,"_on_mouse_entered")

export(Array, Resource) var objects = [
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null,
	null, null ,null, null ,null, null, null, null
]

func set_item(item_index, object):
	var PreviousItem = objects[item_index]
	objects[item_index] = object
	emit_signal("objects_change",[item_index])
	return PreviousItem
	pass
	
func swap_items(item_index,target_onoject_index):
	var targetObject = objects[target_onoject_index]
	var object = objects[item_index]
	objects[target_onoject_index] = object
	objects[item_index] = targetObject
	emit_signal("objects_change",[item_index,target_onoject_index])
	pass
	
func remove_item(item_index):
	var PreviousItem = objects[item_index]
	objects[item_index] = null
	emit_signal("objects_change",[item_index])
	return PreviousItem
	pass
	
func get_item(item_index):
	var currentItem = objects[item_index]
	return currentItem
	
