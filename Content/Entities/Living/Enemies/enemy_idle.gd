extends State

@export
var on_alert_state : String
@export
var alert_distance : float = 256

func on_entered(entity: Entity, prev: String) -> void:
	if entity.entity_sprite:
		entity.entity_sprite.play(&"Idle")

func on_update(entity: Entity) -> void:
	apply_gravity(entity)
	if JusticeGlobal.player.position.distance_to(entity.position) <= alert_distance:
		change.emit(self,on_alert_state)
		
func on_damage_taken(victim: Entity,attacker: Entity, hurtBox: EntityHurtbox):
	change.emit(self,on_alert_state)
