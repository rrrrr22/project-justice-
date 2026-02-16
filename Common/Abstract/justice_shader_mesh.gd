@tool
extends MeshInstance2D

func _init() -> void:
	if mesh is QuadMesh:
		mesh.size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
		mesh.center_offset = Vector3(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"),0) / 2
func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var mat = self.material
	if mat is ShaderMaterial:
		mat.set_shader_parameter("camera_position",JusticeGlobal.camera_position)
		if mesh is QuadMesh:
			mat.set_shader_parameter("mesh_width",mesh.size.x)
			mat.set_shader_parameter("mesh_height",mesh.size.y)
	pass
