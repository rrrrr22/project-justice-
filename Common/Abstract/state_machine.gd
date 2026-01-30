class_name StateMachine extends Node
var current : State
var states : Dictionary[String,State] = {}
@export
var starting_state : State
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
	
