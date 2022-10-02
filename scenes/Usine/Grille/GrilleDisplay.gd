extends GridContainer
signal Send_Troop(speed,shoot_frequency,shoot_range)
var grille = preload("res://scenes/Usine/Grille/Grille.tres")


func _ready():
	grille.connect("objects_change",self,"_on_items_changed")
	$Timer.connect("timeout",self,"Send_Troops")
	update_inventory_display()
	
func reset_grid():
	for item_index in grille.objects.size():
		grille.objects[item_index] = null
		update_grille_slot_display(item_index)
	
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

func Send_Troops():
	
	var speed:int = 0
	var shoot_frequency:int = 0
	var shoot_range = 0
	
	for item_index in grille.objects.size():
		var tile = grille.objects[item_index]
		if	tile != null and tile.name == "Chassie":
			var tileSurround = get_surronding_till(item_index)			
			speed = get_speed(tileSurround)
			shoot_frequency = get_cadence(tileSurround)
			shoot_range = get_range(tileSurround)
			emit_signal("Send_Troop",speed,shoot_frequency,shoot_range)
	
	reset_grid()

func get_surronding_till(item_index) -> objects:
	var tileUp
	var	tileDown
	var tileLeft
	var tileRight
	if item_index - 8 > 0 :
		 tileUp = grille.objects[item_index - 8]
	else:
		 tileUp = null
	
	if item_index + 8 < grille.objects.size():
		 tileDown = grille.objects[item_index + 8]
	else:
		 tileDown = null
	
	if (item_index % 8 != 0 ):
		 tileLeft = grille.objects[item_index - 1]
	else:
		 tileLeft = null

	if (item_index % 8 != 7 ):
		 tileRight = grille.objects[item_index + 1]
	else:
		 tileRight = null
		
	var tileSurround = [tileUp,
						tileDown,
						tileLeft,
						tileRight
						]
	return tileSurround

func get_speed(TileSurround) -> int:
	var speed:int = 30
	for tile in TileSurround:
		if(tile != null and tile.name == "reactor"):
			speed += 50
	return speed

func get_range(TileSurround):
	var weaponrange = 0
	for tile in TileSurround:
		if(tile != null and tile.name == "Weapon"):
			weaponrange += 50
	return(weaponrange)

func get_cadence(TileSurround):
	var cadence = 1
	for tile in TileSurround:
		if(tile != null and tile.name == "Weapon"):
			cadence -= 0.2
	return(cadence)
