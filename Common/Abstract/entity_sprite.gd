extends AnimatedSprite2D

@export
var entity: Entity
@export
var rotate_towards_velocity : bool = false

func _ready() -> void:
	rotate_to_velocity()
	
func _physics_process(delta: float) -> void:
	rotate_to_velocity()

func rotate_to_velocity():
	if entity && rotate_towards_velocity:
		rotation = entity.velocity.angle()
