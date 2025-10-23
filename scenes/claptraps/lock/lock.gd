class_name Lock
extends Thing

func _ready() -> void:
	self.gobject = 21
	self.name = "Lock"


func hit(_hitby: Thing) -> void:
	create("Blank", 0, grid_pos)


func check_squash(object: Thing) -> bool:
	if object.name == "Key":
		return true
	else:
		return false
