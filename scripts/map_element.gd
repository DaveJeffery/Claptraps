extends Resource
class_name MapElement
# Optional: give a custom resource type id so it shows nicely in the "New Resource" dialog.
# @export_category("Level")

# Use typed properties so loaded resource gives you properly typed fields.
@export var position: Vector2i = Vector2i.ZERO
@export var tile: int = 0
@export var destination: Vector2i = Vector2i(-1, -1)
