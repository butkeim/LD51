extends GridContainer

var Tapis = preload("res://scenes/Usine/Tapis/Tapis.tres")

var obj_instance = [preload("res://scenes/Usine/Objects/Chassie.tres"),
					preload("res://scenes/Usine/Objects/reactor.tres"),
					preload("res://scenes/Usine/Objects/Weapon.tres"),
					null]
					
func _ready():
	Tapis.connect("objects_change",self,"_on_items_changed")
	$Timer.connect("timeout",self,"deplacement_tapis")
	intialisation()
	#u#pdate_inventory_display()
	
func update_Tapis_display():
	for item_index in Tapis.objects.size():
		update_Tapis_slot_display(item_index)
	
func update_Tapis_slot_display(object_index):
	var TapisSlotDisplay = get_child(object_index)
	var item = Tapis.objects[object_index]
	TapisSlotDisplay.display_item(item)

	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_Tapis_slot_display(item_index)

func deplacement_tapis():
	for col in range(3,0,-1):
		for line in 12:
			Tapis.set_item(col + 4*line, Tapis.objects[col + 4*line - 1])
	new_col()

func intialisation():
	for item_index in Tapis.objects.size():
		Tapis.set_item(item_index,obj_instance[get_rand()])

func new_col():
	for i in 12:
		Tapis.set_item(i*4,obj_instance[get_rand()])
	
func get_rand() -> int:
	var tablID = randi() % obj_instance.size()
	return(tablID)
