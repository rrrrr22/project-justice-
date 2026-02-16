extends State

func on_entered(entity: Entity, prev: String) -> void:
	jump(entity)
	entity.velocity.x = 1 if entity.entity_sprite && entity.entity_sprite.flip_h else -1
	entity.entity_sprite.play(&"Dead")
func on_update(entity: Entity) -> void:
	apply_gravity(entity)
	if entity.is_grounded && !entity.is_grounded_last_frame:
		entity.velocity.x = 0
