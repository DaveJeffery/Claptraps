class_name Lock
extends Thing

func _ready() -> void:
	self.gobject = 21
	self.name = "Lock"


func hit(_hitby: Thing) -> void:
	create("Blank", Direction.STILL, grid_pos)


func check_squash(object: String) -> bool:
	if object == "Key":
		return true
	else:
		return false
