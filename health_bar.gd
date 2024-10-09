extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = self.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_on_hit(health) -> void:
	self.value = health
	print(self.value)
