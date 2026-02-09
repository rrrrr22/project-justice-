class_name JusticeColBody extends CharacterBody2D

@export 
var entity : Entity

@export
var rays_position : Array[Marker2D]

func _ready() -> void:
	self.top_level = true

func collide_and_slide_no_delta() -> void:
	entity.just_landed = !entity.is_grounded
	entity.is_grounded_last_frame = entity.is_grounded
	entity.is_grounded = false
	entity.is_hitting_ceiling = false
	entity.is_hitting_wall = false
	entity.is_below_platform = false
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.get_normal()) * 0.5
		var colllision_slide = move_and_collide(collision.get_remainder().slide(collision.get_normal()))
		if collision:
			if collision.get_angle() > PI - 0.1:
				entity.is_hitting_ceiling = true

	for marker in rays_position:
		var wall_ray = PhysicsRayQueryParameters2D.create(marker.global_position,marker.global_position + (Vector2.RIGHT if marker.position.x > 0 else Vector2.LEFT))
		wall_ray.exclude = [get_rid()]
		wall_ray.collision_mask = self.collision_mask
		var collider_wall = self.get_world_2d().direct_space_state.intersect_ray(wall_ray) 
		if !collider_wall.is_empty():
			entity.is_hitting_wall = true
		
		var ground_ray = PhysicsRayQueryParameters2D.create((marker.global_position).floor(),(marker.global_position).floor() + Vector2.DOWN)
		ground_ray.exclude = [get_rid()]
		ground_ray.collision_mask = self.collision_mask
		var collider_ground = self.get_world_2d().direct_space_state.intersect_ray(ground_ray) 
		if !collider_ground.is_empty() && entity.velocity.y >= 0:
			entity.is_grounded = true
			if entity.just_landed:
				entity.just_landed = false
			position.y = floor(position.y)
			if collider_ground["collider"] is TileMapLayer:
				var tile_map_layer = collider_ground["collider"] as TileMapLayer
				if tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider_ground["position"])) && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider_ground["position"])).get_collision_polygons_count(1) > 0 && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider_ground["position"])).is_collision_polygon_one_way(1,0):
					entity.is_below_platform = true
