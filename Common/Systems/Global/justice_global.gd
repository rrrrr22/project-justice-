extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"

var camera_position : Vector2
var main_character : Entity
var mc_max_speed_grounded : float = 2
var mc_weapon_cooldown : int = 0

@export_file
var starting_room : String

enum aim_state
{
	UP = 1,
	STRAIGHT = 0,
	DOWN = 2
}

func mc_fire_weapon(entity: Entity):
	if JusticeGlobal.mc_weapon_cooldown > 0:
		return
	JusticeGlobal.mc_weapon_cooldown = 9
	var projectile = Utils.new_entity("justice_bullet", entity)
	projectile.position = entity.position
	match(entity.current_aim_state):
		JusticeGlobal.aim_state.STRAIGHT: 
			projectile.position.x += -5 if entity.entitySprite.flip_h else 5
			projectile.velocity.x = 8 * (-1 if entity.entitySprite.flip_h else 1) 
		JusticeGlobal.aim_state.UP:
			projectile.position.y += -5
			projectile.position.x += -5 if entity.entitySprite.flip_h else 5
			projectile.velocity.y = -8
		JusticeGlobal.aim_state.DOWN:
			projectile.position.y += 5
			projectile.position.x += -5 if entity.entitySprite.flip_h else 5
			projectile.velocity.y = 8
	projectile.entitySprite.rotation = projectile.velocity.angle()
	entity.entities_pool.add_entity(projectile)

func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	load_room(starting_room)

func _physics_process(delta: float) -> void:
	if mc_weapon_cooldown > 0:
		mc_weapon_cooldown -= 1;
