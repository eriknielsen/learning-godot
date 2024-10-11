extends Node3D

signal on_kill

@export var weapon: PackedScene
@export var scenePerLevel: int
@export var dmgPerLevel: int
@export var durationPerLevel: int
@export var cooldownPerLevel: int 
@export var offset: int
@export var full_rotation_time: float

var weapons = []
var angles = []
var rotation_speed_rad: float
var death_time: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initialize(1, Vector3(0,0,0))
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Time.get_ticks_msec() > death_time:
		queue_free()
		pass

	for i in angles.size():
		angles[i] += rotation_speed_rad * delta
		var angle = angles[i] 
		var new_position = Vector3(offset * cos(angle), 0, offset * sin(angle))
		weapons[i].position = new_position
		i += 1


func initialize(level:int, player_position):
	death_time = Time.get_ticks_msec() + (durationPerLevel * level * 1000)
	# Spawn weapon in a cricle
	rotation_speed_rad = 2 * PI / full_rotation_time
	for i in scenePerLevel * level:
		var instance = weapon.instantiate()
		add_child(instance)
		weapons.append(instance)
		# Put it in a circle
		var angle = (35 * i) + PI * 2
		angles.append(angle)
		var x = cos(angle) * offset
		var z = sin(angle) * offset
		instance.position = Vector3(x, 0, z)
		
		# Listen to the area enter to deal damage
		instance.get_node("EnemyDetector").body_entered.connect(on_weapon_entered)#.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
		
func on_weapon_entered(body):
	body.queue_free()
	on_kill.emit()
