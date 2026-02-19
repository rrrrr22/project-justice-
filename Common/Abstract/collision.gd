class_name JusticeColBody extends CharacterBody2D

@export 
var entity : Entity

func _ready() -> void:
	self.top_level = true

func collide_and_slide_no_delta() -> void:
	entity.just_landed = !entity.is_grounded
	entity.is_grounded_last_frame = entity.is_grounded
	entity.is_grounded = false
	entity.is_hitting_ceiling = false
	entity.is_hitting_wall = false
	entity.is_below_platform = false
	var vel = velocity
	velocity *= ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
	var collision = move_and_slide()
	if collision && is_on_floor() && get_last_slide_collision().get_collider() is TileMapLayer:
		var tile_map_layer = get_last_slide_collision().get_collider() as TileMapLayer
		if tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(get_last_slide_collision().get_position())) && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(get_last_slide_collision().get_position())).get_collision_polygons_count(1) > 0 && tile_map_layer.get_cell_tile_data(tile_map_layer.local_to_map(get_last_slide_collision().get_position())).is_collision_polygon_one_way(1,0):	
			entity.is_below_platform = true
	velocity = vel
	entity.is_grounded = is_on_floor()
	entity.is_hitting_ceiling = is_on_ceiling()
	entity.is_hitting_wall = is_on_wall()
	
	
