extends Resource
class_name LevelData
# Optional: give a custom resource type id so it shows nicely in the "New Resource" dialog.
# @export_category("Level")

# Use typed properties so loaded resource gives you properly typed fields.
@export var map: Array = []
@export var map_size: Vector2i = Vector2i.ZERO
@export var dave_pos: Vector2i = Vector2i.ZERO
@export var minimum_score: int = 0
