class_name Section extends Node2D

@export
var camera : Camera2D

@export
var sectionMainTiles : TileMapLayer

func _ready() -> void:
	section_ready()
	
func _physics_process(delta: float) -> void:
	
	camera.position = JusticeGlobal.main_character.position
	if JusticeGlobal.main_character.entitySprite.flip_h:
		camera.position.x -= 32
	else:
		camera.position.x += 32
	
	MetSys.get_current_room_instance().adjust_camera_limits(camera)
	section_update()

func section_update():
	pass
	
func secion_entered():
	pass
	
func section_exited():
	pass

func section_ready():
	pass
