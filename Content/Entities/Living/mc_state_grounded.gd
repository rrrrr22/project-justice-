extends State
var stopped_moving : bool = false

func on_entered(entity: Entity, prev: String) -> void:
	entity.entitySprite.play(&"Idle")
	if !Input.is_action_pressed("A") && !Input.is_action_pressed("D"):
		entity.velocity.x = 0

func on_update(entity: Entity) -> void:
	if !entity.is_grounded:
		change.emit(self,"Jumping")
	
	if stopped_moving:
		entity.velocity.x = move_toward(entity.velocity.x,0, 0.1)
	stopped_moving = true
	if Input.is_action_pressed("A"):
		entity.velocity.x = move_toward(entity.velocity.x,-JusticeGlobal.mc_max_speed_grounded,0.5)
		entity.entitySprite.play(&"Walk",lerp(0.,2.,-entity.velocity.x/JusticeGlobal.mc_max_speed_grounded))
		entity.entitySprite.flip_h = true
		stopped_moving = false
	if Input.is_action_pressed("D"):
		entity.velocity.x = move_toward(entity.velocity.x,JusticeGlobal.mc_max_speed_grounded,0.5)
		entity.entitySprite.play(&"Walk",lerp(0.,2.,entity.velocity.x/JusticeGlobal.mc_max_speed_grounded))
		entity.entitySprite.flip_h = false
		stopped_moving = false
	if entity.velocity.x == 0:
		entity.entitySprite.play(&"Idle")
	
	
func on_key_pressed(entity: Entity, event: InputEvent):
	if event.is_action_pressed("Jump"):
		change.emit(self,"Jumping")
