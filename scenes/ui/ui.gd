extends Control


onready var progress_bar: ProgressBar = $ProgressBar
onready var base_armor: ProgressBar = $BaseArmor

func _ready() -> void:
	pass # Replace with function body.

func set_remaining(remaining: float):
	progress_bar.value = remaining

func set_base_progress(armor: float):
	base_armor.value = armor
