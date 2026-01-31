class_name EntityHitbox extends Area2D

var isPlayerSided : bool = false

@export
var entity : Entity

func take_hit(hurtBox : EntityHurtbox):
	entity.on_damage_dealt(hurtBox.entity,hurtBox)
