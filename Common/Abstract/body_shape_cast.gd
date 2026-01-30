extends RayCast2D

@export
var entity : Entity
@export 
var is_for_ceiling: bool


func _physics_process(delta: float) -> void:
	if is_colliding():
		if is_for_ceiling:
			entity.is_hitting_ceiling = true
		if !is_for_ceiling:
			entity.is_grounded = true
	else:
		if !is_for_ceiling:
			entity.is_grounded = false
		else:
			entity.is_hitting_ceiling = false
