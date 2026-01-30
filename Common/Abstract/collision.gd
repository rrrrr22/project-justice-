class_name JusticeColBody extends CharacterBody2D

func _ready() -> void:
	self.top_level = true

func collide_and_slide_no_delta() -> void:
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.get_normal())
		move_and_collide(collision.get_remainder().slide(collision.get_normal()))
