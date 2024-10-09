extends Camera3D

@export var target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var target_position =  Vector3.ZERO
	#
	#target_position.x = target.basis.x
	#target_position.y = target.basis.y
	#target_position.z = target.basis.z
	if target != null:
		look_at_from_position(position, target.position)
	
		position.z = target.position.z
