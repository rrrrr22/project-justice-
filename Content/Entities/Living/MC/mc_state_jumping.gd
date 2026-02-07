extends State

func reset_state_vars():
	coyote_timer = 0
	grounded_state_reset_delay = 0
	
var grounded_state_reset_delay : int = 0
var coyote_timer : int = 0
func on_entered(entity: Entity, prev: String) -> void:
	coyote_timer = 6
	entity.entity_sprite.play(&"MidAir" + str(entity.current_aim_state))
	if Input.is_action_just_pressed("Jump") && (!Input.is_action_pressed("S") || !entity.is_below_platform):
		jump(entity)
	if Input.is_action_pressed("S") && Input.is_action_pressed("Jump") && entity.is_below_platform:
		entity.is_falling_through_platform = true

func on_update(entity: Entity) -> void:
	coyote_timer = move_toward(coyote_timer, 0, 1)
	if Input.is_action_pressed("A") && !Input.is_action_pressed("D"):
		entity.velocity.x = move_toward(entity.velocity.x,-JusticeGlobal.mc_max_speed_grounded,0.25)
		entity.entity_sprite.flip_h = true
	if Input.is_action_pressed("D") && !Input.is_action_pressed("A"):
		entity.velocity.x = move_toward(entity.velocity.x,JusticeGlobal.mc_max_speed_grounded,0.25)
		entity.entity_sprite.flip_h = false
	if Input.is_action_pressed("S") && Input.is_action_pressed("Jump") && entity.is_below_platform:
		entity.is_falling_through_platform = true
	else:
		entity.is_falling_through_platform = false
	entity.entity_sprite.play(&"MidAir" + str(entity.current_aim_state))
	entity.velocity.y = jump_update(entity,!Input.is_action_pressed("Jump") && grounded_state_reset_delay > 5).y
	if entity.velocity.y > 0 && !entity.is_falling_through_platform && grounded_state_reset_delay > 5:
		entity.body.set_collision_mask_value(3,true)
	else:
		entity.body.set_collision_mask_value(3,false)
	if entity.is_grounded && !just_jumped && grounded_state_reset_delay > 5:
		grounded_state_reset_delay = 0
		change.emit(self,"Grounded")
	grounded_state_reset_delay += 1
	if Input.is_action_pressed("S"):
		entity.current_aim_state = JusticeGlobal.aim_state.DOWN
	else: if Input.is_action_pressed("W"):
		entity.current_aim_state = JusticeGlobal.aim_state.UP
	else:
		entity.current_aim_state = JusticeGlobal.aim_state.STRAIGHT
	if JusticeGlobal.mc_weapon_cooldown <= 0 && Input.is_action_pressed("Shoot"):
		JusticeGlobal.mc_fire_weapon(entity)
	
func on_exit(entity: Entity, next: String) -> void:
	jump_new_velocity = Vector2.ZERO
func on_key_pressed(entity: Entity, event: InputEvent):
	if event.is_action_pressed("Jump") && coyote_timer > 0:
		jump(entity)
		coyote_timer = 0
