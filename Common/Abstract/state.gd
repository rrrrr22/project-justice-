class_name State extends Node 

var jump_old_velocity : Vector2 = Vector2.ZERO
var jump_new_velocity : Vector2 = Vector2.ZERO
var jump_applied_velocity : Vector2 = Vector2.ZERO

var just_jumped : bool = false

@export
var jump_height : float = 128
@export
var time_to_peak : float = 60
@export
var time_to_floor : float = 45

var cant_jump : bool = false
var is_jumping : bool = false
var is_falling : bool = false

var peak_gravity : float:
	get:
		return 2 * jump_height / (time_to_peak * time_to_peak)
var fall_gravity : float:
	get:
		return 2 * jump_height / (time_to_floor * time_to_floor)
var jump_force : float:
	get:
		return -2 * jump_height / time_to_peak

signal change(state: State, next_state_name: String)

func on_entered(entity: Entity, prev: String) -> void:
	pass

func on_update(entity: Entity) -> void:
	pass

func on_exit(entity: Entity, next: String) -> void:
	pass

func on_damage_taken(entity: Entity, hurtBox: EntityHurtbox):
	pass
func on_damage_dealt(entity: Entity, hurtBox: EntityHurtbox):
	pass
func on_key_pressed(entity: Entity, event: InputEvent):
	pass

func on_jumping(entity: Entity) -> void:
	pass

func jump_vars_update(entity: Entity):	
	if is_jumping && !cant_jump:
		cant_jump = false
	else: if entity.is_grounded:
		cant_jump = true
		is_jumping = false

func jump_update(entity: Entity, cancel_peaking : bool = false) -> Vector2:
	if !entity.body:
		return Vector2.ZERO

	jump_applied_velocity = entity.velocity
	jump_old_velocity = jump_new_velocity
	jump_new_velocity.y += gravity(entity, cancel_peaking)
	jump_new_velocity.y = clampf(jump_new_velocity.y,jump_force if !entity.is_hitting_ceiling else 0., 9999. if !entity.is_grounded else 0.)
	jump_applied_velocity.y = (jump_old_velocity.y + jump_new_velocity.y) * .5
	return jump_applied_velocity
	
func jump(entity: Entity):
	jump_new_velocity.y = jump_force
	is_jumping = true
	just_jumped = true
	on_jumping(entity)

func gravity(entity: Entity, to_falling : bool = false):
	is_falling = (!entity.is_grounded && jump_new_velocity.y >= 0) || to_falling 
	return fall_gravity if is_falling else peak_gravity
