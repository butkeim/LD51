extends CenterContainer

var grille = preload("res://scenes/Usine/Grille/Grille.tres")
var Tapis = preload("res://scenes/Usine/Tapis/Tapis.tres")
onready var ObjectTextureRect = $ObjectTextureRect
var MouseOver = false

var dragged: TextureRect = null

func _ready():
	self.connect("mouse_entered",self,"_on_mouse_entered")
	self.connect("mouse_exited",self,"_on_mouse_exit")
	
func _process(delta: float) -> void:
	ObjectTextureRect.rect_pivot_offset = Vector2(32,32)
	if is_instance_valid(dragged):
		var mouse_pos = get_global_mouse_position()
		dragged.set_position(Vector2(mouse_pos.x - 1000, mouse_pos.y - 32))


func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and MouseOver:
		var item_index = get_index()
		ObjectTextureRect.rect_rotation = ObjectTextureRect.rect_rotation + 90
		print(item_index)

func _on_mouse_entered():
	var item_index = get_index()
	var item = grille.get_item(item_index)#,item_index)
	if item is objects:
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = load("res://assets/sprites/factory/factory_tile/Grid_Motor.png")
	MouseOver = true
	#if item != null:
	#	emit_signal("_send_item_info",item.Description)
	
	
func _on_mouse_exit():
	MouseOver = false
	var item_index = get_index()
	var item = grille.get_item(item_index)
	if item is objects:
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = load("res://assets/sprites/ui/transparent.png")


#if event.button_index == BUTTON_LEFT and event.pressed:
		
func display_item(item):
	if item is objects:
		ObjectTextureRect.texture  = item.texture
	else:
		ObjectTextureRect.texture = load("res://assets/sprites/ui/transparent.png")
		
func get_drag_data(_position):
	var item_index = get_index()
	var item = grille.remove_item(item_index)
	if	item is objects:
		var data = {}
		data.object = item
		data.object_index = item_index
		data.texture = item.texture
		data.origine = "grille"
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		dragged = dragPreview
		set_drag_preview(dragPreview)
		return	data
	
	
func can_drop_data(_position,data):
	var my_item_index = get_index()
	var my_item = grille.objects[my_item_index]
	if data.origine == "tapis":
		return(my_item == null)  
	else:
		return(true) 
	
	
	#data is Dictionary and
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = grille.objects[my_item_index]
	if(my_item == null and data.origine == "tapis"):
		grille.set_item(my_item_index, data.object)
	elif(data.origine == "grille"):
		grille.swap_items(my_item_index, data.object_index)
		grille.set_item(my_item_index, data.object)
		
	dragged = null
	pass
