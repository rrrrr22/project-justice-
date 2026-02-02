class_name Entity extends Node2D

var entity_owner = null
var old_velocity : Vector2 = Vector2.ZERO
var old_position : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
@export 
var entitySprite : AnimatedSprite2D
@export 
var body : JusticeColBody
@export
var state_machine : StateMachine
@export
var entity_stats : EntityStats
@export 
var entities_pool : EntitiesPool

@export
var audio_player_2d: AudioStreamPlayer2D
@export
var on_spawn_sound: AudioStream
@export 
var on_kill_sound: AudioStream
@export 
var pitch_difference_spawn : float
@export 
var pitch_difference_kill : float
@export 
var pitch_spawn : float
@export 
var pitch_kill : float

var is_grounded : bool = false
var is_hitting_ceiling : bool = false
var current_aim_state : JusticeGlobal.aim_state = JusticeGlobal.aim_state.STRAIGHT


func _ready() -> void:
	if body:
		body.global_position = position
	Utils.emit_sound(on_spawn_sound,audio_player_2d,pitch_spawn,pitch_difference_spawn)
	on_ready()
	
func on_ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	old_velocity = velocity
	old_position = position
	pre_update()
	if state_machine:
		state_machine.update()
	if body:
		body.velocity = velocity
		body.collide_and_slide_no_delta()
		position = body.global_position
		velocity = body.velocity
	else:
		position += velocity
	post_update()
	
func pre_update():
	pass
func post_update():
	pass
	
func on_damage_taken(entity: Entity, hurtBox: EntityHurtbox):
	entity_stats.take_damage(hurtBox.damage_amount)
	state_machine.on_damage_taken(entity, hurtBox)
	
func on_damage_dealt(entity: Entity, hurtBox: EntityHurtbox):
	state_machine.on_damage_dealt(entity, hurtBox)

func on_killing_an_entity(entity: Entity, hurtBox: EntityHurtbox):
	pass
	
func kill():
	queue_free()
	on_kill()
	
func on_kill():
	pass
