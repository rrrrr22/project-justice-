extends State

@export 
var max_time_left = 30
var time_left = max_time_left

func on_update(entity: Entity) -> void:
	if time_left <= 0:
		entity.kill()
	time_left -= 1
