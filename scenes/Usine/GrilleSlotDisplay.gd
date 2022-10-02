extends CenterContainer

var grille = preload("res://scenes/Usine/Grille.tres")
onready var ObjectTextureRect = $ObjectTextureRect

func display_item(item):
	if item is objects:
		print(item.name)
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = load("res://assets/sprites/factory/factory_tile/grid.png")

func get_drag_data(_position):
	var item_index = get_index()
	var item = grille.remove_item(item_index)
	if	item is objects:
		var data = {}
		data.object = item
		data.object_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		return	data
	
	
func can_drop_data(_position,data):
	return  data.has("object")
	pass
	
	#data is Dictionary and
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = grille.objects[my_item_index]
	grille.swap_items(my_item_index, data.object_index)
	grille.set_item(my_item_index, data.object)
	pass
