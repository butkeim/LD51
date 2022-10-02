extends CenterContainer

var grille = preload("res://scenes/Usine/Grille/Grille.tres")
onready var ObjectTextureRect = $ObjectTextureRect

var dragged: TextureRect = null

func _process(delta: float) -> void:
	if is_instance_valid(dragged):
		dragged.set_position(get_global_mouse_position())

func display_item(item):
	if item is objects:
		ObjectTextureRect.texture  = item.texture
		#ObjectTextureRect.rect_scale = Vector2(0.25,0.25)

	else:
		ObjectTextureRect.texture = load("res://assets/sprites/factory/factory_tile/grid.png")
		#ObjectTextureRect.rect_scale = Vector2(1,1)
		
func get_drag_data(_position):
	var item_index = get_index()
	var item = grille.remove_item(item_index)
	if	item is objects:
		var data = {}
		data.object = item
		data.object_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		dragged = dragPreview
		set_drag_preview(dragPreview)
		return	data
	
	
func can_drop_data(_position,data):
	return  true #data.has("object")
	pass
	
	#data is Dictionary and
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = grille.objects[my_item_index]
	grille.swap_items(my_item_index, data.object_index)
	grille.set_item(my_item_index, data.object)
	dragged = null
	pass
