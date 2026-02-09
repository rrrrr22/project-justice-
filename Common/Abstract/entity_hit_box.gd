class_name EntityHitbox extends Area2D

@export
var isPlayerSided : bool = false

@export
var entity : Entity

@export 
var can_take_damage : bool = true

func take_hit(hurtBox : EntityHurtbox):
	if can_take_damage:
		entity.on_damage_taken(hurtBox.entity,hurtBox)
