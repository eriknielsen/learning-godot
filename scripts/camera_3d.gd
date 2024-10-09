extends Camera3D

@export var target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if target != null:
		look_at_from_position(position, target.position)
	
		position.z = target.position.z
