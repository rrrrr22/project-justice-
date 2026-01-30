extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"

var camera_position : Vector2
var main_character : Entity
var mc_max_speed_grounded : float = 2
@export_file("room_link")
var starting_room : String

func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	load_room(starting_room)
