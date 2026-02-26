class_name Item extends Resource

@export var texture : Texture2D
@export var item_name : String
@export var item_desc : String
@export var item_popup_texts : Array[String]
@export var item_consumable : bool

func on_consumed():
	pass

func on_added():
	pass

func on_target_kill(attacker : Entity, victim : Entity):
	pass

func on_target_hit(attacker : Entity, victim : Entity):
	pass

func on_weapon_fired(projectile : Entity):
	pass
	
func on_mc_taking_hit(attacker : Entity):
	pass
	
func on_mc_enter_section(section : Section):
	pass

func on_mc_jump():
	pass
