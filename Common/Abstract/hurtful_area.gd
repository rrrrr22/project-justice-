class_name EntityHurtbox extends EntityIsAreaActive

@export
var damage_amount : int = 1

@export
var hitbox_penetration = 1

@export
var isPlayerSided : bool = false

var exclude : Array[EntityHitbox] = []
var hit_something : bool = false
func run():
	scan()
	
func scan() -> void:
	hit_something = false
	for node in get_overlapping_areas():
		if node is EntityHitbox:
			if !hit_something && node.entity.is_active && !exclude.has(node) && isPlayerSided != node.isPlayerSided:
				if hitbox_penetration != -1:
					exclude.append(node)
				hit_something = true
				node.take_hit(self)
				on_hit(node)
				if hitbox_penetration == 0:
					break
func on_hit(hitbox : EntityHitbox):
	if hitbox_penetration > 0:
		hitbox_penetration -= 1
	if hitbox_penetration == 0:
		entity.kill()
func on_tile_hit(body: Node2D):
	if !(body is JusticeColBody):
		entity.kill()
