class_name JusticeColBody extends CharacterBody2D

@export 
var entity : Entity

@export
var collision_detection_raycasts : Array[FloorAndCeilingDetectionRay]

func _ready() -> void:
	self.top_level = true

func collide_and_slide_no_delta() -> void:
	entity.is_grounded = false
	entity.is_hitting_ceiling = false
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.get_normal())
		for ray in collision_detection_raycasts:
			if ray.is_colliding():
				if !ray.is_for_ceiling:
					entity.is_grounded = true
				if ray.is_for_ceiling:
					entity.is_hitting_ceiling = true
		move_and_collide(collision.get_remainder().slide(collision.get_normal()))
