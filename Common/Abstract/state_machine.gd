class_name StateMachine extends Node
var current : State
var states : Dictionary[String,State] = {}
@export
var starting_state : State
@export
var on_killed_state : State
@export
var entity : Entity
func _ready() -> void:
	for c in get_children():
		if c is State:
			states[c.name.to_lower()] = c;
			c.change.connect(on_changed)
			
	if starting_state:
		starting_state.on_entered(entity,"")
		current = starting_state;
	pass
func update() -> void:
	if current:
		current.just_jumped = false
		current.jump_vars_update(entity)
		current.on_update(entity)
	pass
func on_damage_taken(entity: Entity, hurtBox: EntityHurtbox):
	current.on_damage_taken(entity, hurtBox)
	if entity.entity_stats.current_hp <= 0:
		change_to_dead_state()

func on_damage_dealt(entity: Entity, hurtBox: EntityHurtbox):
	current.on_damage_dealt(entity, hurtBox)

func on_changed(state : State, next_state_name : String) -> void:
	if state != current:
		return
	var new_state : State = states.get(next_state_name.to_lower())
	if !new_state:
		return
	if current:
		current.on_exit(entity,new_state.name.to_lower())
	new_state.on_entered(entity, state.name.to_lower())
	current = new_state;
	pass
func _unhandled_key_input(event: InputEvent) -> void:
	if current:
		current.on_key_pressed(entity,event)

func change_to_dead_state():
	if !on_killed_state:
		return
	on_killed_state.on_entered(entity,current.name.to_lower())
	current = on_killed_state
