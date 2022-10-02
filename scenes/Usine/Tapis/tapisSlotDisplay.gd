extends CenterContainer

var Tapis = preload("res://scenes/Usine/Tapis/Tapis.tres")
onready var ObjectTextureRect = $ObjectTextureRect

var dragged: TextureRect = null

func _process(delta: float) -> void:
	if is_instance_valid(dragged):
		dragged.set_position(get_global_mouse_position())

func display_item(item):
	if item is objects:
		print(item.name)
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = null

func get_drag_data(_position):
	var item_index = get_index()
	var item = Tapis.remove_item(item_index)
	if	item is objects:
		var data = {}
		data.object = item
		data.object_index = item_index
		data.object_texture = item.texture
		var dragPreview = TextureRect.new()
		dragged = dragPreview
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		return	data
	
	
func can_drop_data(_position,data):
	return data.has("object") #and data.object_texture == null
	pass
	
	#data is Dictionary and
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = Tapis.objects[my_item_index]
	Tapis.swap_items(my_item_index, data.object_index)
	Tapis.set_item(my_item_index, data.object)
	pass
