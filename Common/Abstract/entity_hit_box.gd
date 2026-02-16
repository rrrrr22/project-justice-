class_name EntityHitbox extends Area2D

@export
var isPlayerSided : bool = false

@export
var entity : Entity

@export 
var can_take_damage : bool = true

func take_hit(hurtBox : EntityHurtbox):
	if entity.is_active && entity.current_iframes <= 0 && can_take_damage:
		if entity.entity_sprite:
			entity.entity_sprite.flash_progress = 1
		entity.on_damage_taken(hurtBox.entity,hurtBox)
