class_name EntityStats extends Resource

@export
var max_hp = 1
var current_hp = max_hp
@export
var damage = 0
@export
var defense = 0
@export
var iframes = 0

func init_stats():
	current_hp = max_hp

func take_damage(damage: int):
	current_hp -= damage
	
