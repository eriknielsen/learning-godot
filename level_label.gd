extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text(level):
	text = tr("level_label") + "%s" % level


func _on_player_on_get_level(amount: Variant) -> void:
	update_text(amount)
