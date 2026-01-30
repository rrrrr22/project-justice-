extends State

var grounded_state_reset_delay : int = 0

func on_entered(entity: Entity, prev: String) -> void:
	if Input.is_action_just_pressed("Jump"):
		entity.entitySprite.play(&"MidAir")
		jump(entity)

func on_update(entity: Entity) -> void:
	if Input.is_action_pressed("A"):
		entity.velocity.x = move_toward(entity.velocity.x,-JusticeGlobal.mc_max_speed_grounded,0.25)
		entity.entitySprite.flip_h = true
	if Input.is_action_pressed("D"):
		entity.velocity.x = move_toward(entity.velocity.x,JusticeGlobal.mc_max_speed_grounded,0.25)
		entity.entitySprite.flip_h = false
		
	entity.velocity.y = jump_update(entity,!Input.is_action_pressed("Jump") && grounded_state_reset_delay > 5).y
	if entity.is_grounded && !just_jumped && grounded_state_reset_delay > 5:
		grounded_state_reset_delay = 0
		change.emit(self,"Grounded")
	grounded_state_reset_delay += 1
		
