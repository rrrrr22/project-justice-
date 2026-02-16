class_name DamageNotify extends Label

var lifetime : int = 30
var spawn_pos : Vector2
func _ready() -> void:
	self.spawn_pos = position
	create_tween().set_trans(Tween.TRANS_QUART).tween_property(self,"position",spawn_pos + Vector2.UP * 50,1).finished.connect(queue_free)
