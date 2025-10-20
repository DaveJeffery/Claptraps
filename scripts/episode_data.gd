extends Resource
class_name EpisodeData
# Optional: give a custom resource type id so it shows nicely in the "New Resource" dialog.
# @export_category("Level")

# Use typed properties so loaded resource gives you properly typed fields.
@export var levels: Array[LevelData] = []                # keep nested arrays (tile pairs etc.)
@export var def_file: String = ""
