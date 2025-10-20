extends Resource
class_name LevelData
# Optional: give a custom resource type id so it shows nicely in the "New Resource" dialog.
# @export_category("Level")

# Use typed properties so loaded resource gives you properly typed fields.
@export var level_map: Array[MapElement] = []                # keep nested arrays (tile pairs etc.)
@export var def_file: String = ""
@export var level_size: Array[Vector2i] = []     # Array of Vector2i
@export var dave_pos: Array[Vector2i] = []       # Array of Vector2i
@export var minimum_score: Array[int] = []       # Array of int
