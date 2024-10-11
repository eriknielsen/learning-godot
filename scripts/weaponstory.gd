extends HBoxContainer

@export var weapon:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_on_update_inventory(weapons: Variant) -> void:
	for child in get_children():
		child.queue_free()
	for w:Item in weapons:
		var visuals = w.visuals_2d.instantiate()
		add_child(visuals)
