class_name JusticeColBody extends CharacterBody2D

@export 
var entity : Entity

@export
var rays_position : Array[Marker2D]

func _ready() -> void:
	self.top_level = true

func collide_and_slide_no_delta() -> void:
	entity.is_grounded = false
	entity.is_hitting_ceiling = false
	entity.is_below_platform = false
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.get_normal())
		move_and_collide(collision.get_remainder().slide(collision.get_normal()))
		if collision.get_angle() > PI - 0.1:
			entity.is_hitting_ceiling = true
	for marker in rays_position:
		var ray = PhysicsRayQueryParameters2D.create(marker.global_position,marker.global_position + Vector2.DOWN)
		ray.exclude = [get_rid()]
		ray.collision_mask = self.collision_mask
		var collider = self.get_world_2d().direct_space_state.intersect_ray(ray) 
		if !collider.is_empty():
			entity.is_grounded = true
			if collider["collider"] is TileMapLayer:
				var tile_map_layer = collider["collider"] as TileMapLayer
				if tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider["position"])) && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider["position"])).get_collision_polygons_count(1) > 0 && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(collider["position"])).is_collision_polygon_one_way(1,0):
					entity.is_below_platform = true
