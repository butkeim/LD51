extends GridContainer

var grille = preload("res://scenes/Usine/Grille/Grille.tres")


func _ready():
	
	grille.connect("objects_change",self,"_on_items_changed")
	update_inventory_display()
	
func update_inventory_display():
	for item_index in grille.objects.size():
		update_grille_slot_display(item_index)
	
func update_grille_slot_display(object_index):
	var grilleSlotDisplay = get_child(object_index)
	var item = grille.objects[object_index]
	grilleSlotDisplay.display_item(item)
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_grille_slot_display(item_index)
