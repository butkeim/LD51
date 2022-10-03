extends CenterContainer

var Tapis = preload("res://scenes/Usine/Tapis/Tapis.tres")
onready var ObjectTextureRect = $ObjectTextureRect

var dragged: TextureRect = null

func _process(delta: float) -> void:
	if is_instance_valid(dragged):
		dragged.set_position(get_global_mouse_position())

func _on_mouse_entered():
	var item_index = get_index()
	var item = Tapis.get_item(item_index)#,item_index)
	#if item is objects:
	#	ObjectTextureRect.texture  = item.texture
	#else:
	ObjectTextureRect.texture = load("res://assets/sprites/factory/factory_tile/Grid_Reactor.png")
	if item != null:
		emit_signal("_send_item_info",item.Description)
	
	
func _on_mouse_exit():
	var item_index = get_index()
	var item = Tapis.get_item(item_index)
	if item is objects:
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = load("res://assets/sprites/factory/factory_tile/grid.png")



func display_item(item):
	if item is objects:
		print(item.name)
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = null

func get_drag_data(_position):
	var item_index = get_index()
	if item_index%4 == 3:
		var item = Tapis.remove_item(item_index)
		if	item is objects:
			var data = {}
			data.object = item
			data.object_index = item_index
			data.origine = "tapis"
			data.object_texture = item.texture
			var dragPreview = TextureRect.new()
			dragged = dragPreview
			dragPreview.texture = item.texture
			set_drag_preview(dragPreview)
			return	data
	
	
func can_drop_data(_position,data):
		return  true
#return data.has("object") == false#and data.object_texture == null		
#data is Dictionary and
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = Tapis.objects[my_item_index]
	if(my_item == null and data.origine == "tapis"):
		Tapis.swap_items(my_item_index, data.object_index)
		Tapis.set_item(my_item_index, data.object)
	else:
		Tapis.set_item(data.object_index, data.object)
