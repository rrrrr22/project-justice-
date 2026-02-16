class_name Section extends Node2D

@export
var camera : Camera2D
@export 
var camera_3D : Camera3D 
@export
var sectionMainTiles : TileMapLayer

func _ready() -> void:
	section_ready()
	
func _physics_process(delta: float) -> void:
	
	camera.position = JusticeGlobal.main_character.position
	if JusticeGlobal.main_character.entity_sprite.flip_h:
		camera.position.x -= 32
	else:
		camera.position.x += 32
		
	if JusticeGlobal.main_character.current_aim_state == JusticeGlobal.aim_state.UP:
		camera.position.y -= 32
	if JusticeGlobal.main_character.current_aim_state == JusticeGlobal.aim_state.DOWN:
		camera.position.y += 32
	
	if camera_3D:
		camera_3D.position = Vector3(0,0,0.6)
	
	JusticeGlobal.camera_position = camera.get_screen_center_position()
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
