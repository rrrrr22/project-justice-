extends State
var stopped_moving : bool = false
var coyote_timer : int = 0

func reset_state_vars():
	stopped_moving = false
	coyote_timer = 0

func on_entered(entity: Entity, prev: String) -> void:
	entity.entity_sprite.play(&"Idle" + str(entity.current_aim_state))
	if !Input.is_action_pressed("A") && !Input.is_action_pressed("D"):
		entity.velocity.x = 0
	entity.velocity.y = 0
	entity.is_falling_through_platform = true

func on_update(entity: Entity) -> void:
	if !entity.is_grounded:
		change.emit(self,"Jumping")

	if stopped_moving:
		entity.velocity.x = move_toward(entity.velocity.x,0, 0.3)
	stopped_moving = true
	if Input.is_action_pressed("A") && !Input.is_action_pressed("D"):
		entity.velocity.x = move_toward(entity.velocity.x,-JusticeGlobal.mc_max_speed_grounded,0.2)
		entity.entity_sprite.play(&"Walk" + str(entity.current_aim_state),lerp(0.,2.,-entity.velocity.x/JusticeGlobal.mc_max_speed_grounded))
		entity.entity_sprite.flip_h = true
		stopped_moving = false
	if Input.is_action_pressed("D") && !Input.is_action_pressed("A"):
		entity.velocity.x = move_toward(entity.velocity.x,JusticeGlobal.mc_max_speed_grounded,0.2)
		entity.entity_sprite.play(&"Walk" + str(entity.current_aim_state),lerp(0.,2.,entity.velocity.x/JusticeGlobal.mc_max_speed_grounded))
		entity.entity_sprite.flip_h = false
		stopped_moving = false
	if entity.velocity.x == 0:
		entity.entity_sprite.play(&"Idle" + str(entity.current_aim_state))
	entity.body.set_collision_mask_value(3,true)
	if Input.is_action_pressed("S"):
		entity.current_aim_state = JusticeGlobal.aim_state.DOWN
	else: if Input.is_action_pressed("W"):
		entity.current_aim_state = JusticeGlobal.aim_state.UP
	else:
		entity.current_aim_state = JusticeGlobal.aim_state.STRAIGHT
		
	if Input.is_action_pressed("Shoot"):
		JusticeGlobal.mc_fire_weapon(entity)
	
func on_key_pressed(entity: Entity, event: InputEvent):
	if event.is_action_pressed("Jump"):
		change.emit(self,"Jumping")
