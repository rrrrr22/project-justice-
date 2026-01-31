class_name EntityHurtbox extends Area2D

@export
var entity : Entity

@export
var damage_amount : int = 1

@export
var hitbox_penetration = 1

@export
var isPlayerSided : bool = false

var exclude : Array[EntityHitbox] = []

func scan() -> void:
	for node in get_overlapping_bodies():
		if node is EntityHitbox:
			if !exclude.has(node) && isPlayerSided != node.isPlayerSided:
				exclude.append(node)
				node.take_hit(self)
				on_hit(node)
func on_hit(hitbox : EntityHitbox):
	if hitbox_penetration > 0:
		hitbox_penetration -= 1
	if hitbox_penetration == 0:
		entity.kill()
	
