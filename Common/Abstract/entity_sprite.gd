extends AnimatedSprite2D

@export
var entity: Entity
@export
var rotate_towards_velocity : bool = false
var flash_progress : float = 0

func _ready() -> void:
	rotate_to_velocity()
	
func _physics_process(delta: float) -> void:
	if material is ShaderMaterial:
		material.set_shader_parameter(&"progress",flash_progress)
	rotate_to_velocity()
	flash_progress = move_toward(flash_progress,0,0.1)

func rotate_to_velocity():
	if entity && rotate_towards_velocity:
		rotation = entity.velocity.angle()
