extends State

@export
var follow_speed : float = 2
@export
var accel : float = 0.25
@export
var on_lost_player_state : String

func on_update(entity: Entity) -> void:
	if entity.is_hitting_wall && !cant_jump:
		jump(entity)
	if player.position.distance_to(entity.position) <= 512:
		if player.position.x > entity.position.x:
			entity.velocity.x = move_toward(entity.velocity.x,follow_speed,accel)
		else:
			entity.velocity.x = move_toward(entity.velocity.x,-follow_speed,accel)
		if entity.entity_sprite:
			if !entity.is_grounded:
				entity.entity_sprite.play(&"MidAir")
			else:
				entity.entity_sprite.play(&"Walk")
			entity.entity_sprite.flip_h = true if entity.velocity.x < 0 else false
	else:
		change.emit(self,on_lost_player_state)
	apply_gravity(entity)
