extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_text(UiData.experience)

func update_text(experience):
	text = tr("experience_label") + "%s" % experience


func _on_player_on_get_experience(amount: Variant) -> void:
	update_text(amount)
