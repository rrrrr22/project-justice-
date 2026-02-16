extends State

@export var max_time_left = 30
@onready var time_left = max_time_left

func reset_state_vars():
	time_left = max_time_left

func on_update(entity: Entity) -> void:
	if time_left <= 0:
		entity.kill()
	time_left -= 1
