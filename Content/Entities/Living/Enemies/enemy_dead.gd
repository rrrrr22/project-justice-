extends State



func on_entered(entity: Entity, prev: String) -> void:
	entity.velocity.y = -5
	entity.velocity.x = 15 if entity.entity_sprite && entity.entity_sprite.flip_h else -15

func on_update(entity: Entity) -> void:
	apply_gravity(entity)
