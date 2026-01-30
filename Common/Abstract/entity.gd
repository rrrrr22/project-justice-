class_name Entity extends Node2D

#var is_on_floor : bool:
#	get:
	
var old_velocity : Vector2 = Vector2.ZERO
var old_position : Vector2 = Vector2.ZERO
var velocity : Vector2:
	get:
		if body:
			return body.velocity
		return Vector2.ZERO
	set(value):
		if body:
			body.velocity = value
@export 
var entitySprite : AnimatedSprite2D
@export 
var body : JusticeColBody
@export
var state_machine : StateMachine
@export
var collision_cast : RayCast2D

var is_grounded : bool = false
var is_hitting_ceiling : bool = false

func _ready() -> void:
	body.global_position = position

	on_ready()
	
func on_ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if body:
		old_velocity = body.velocity
	old_position = position
	pre_update()
	if state_machine:
		state_machine.update()
	if body:
		body.collide_and_slide_no_delta()
		position = body.global_position
	post_update()
	
func pre_update():
	pass
func post_update():
	pass
