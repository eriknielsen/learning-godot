extends CharacterBody3D

signal on_death
signal on_get_experience(amount)
signal on_get_level(level)
signal on_hit(health)

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20
# Vertical impulse applied to the character upon bouncing over a mob in
# meters per second.
@export var bounce_impulse = 16
@export var starting_weapon: Item
@export var max_health:float = 100

@onready var health = max_health

var target_velocity = Vector3.ZERO

var experience: int
var level: int = 1

var weapons = []

func _ready() -> void:
	weapons.append(starting_weapon)
	#GlobalConsoleCommands.player = self

func _physics_process(delta):
	if Input.is_action_just_pressed("weapon1"):
		spawn_weapon(0)
	elif Input.is_action_just_pressed("weapon2"):
		spawn_weapon(1)
	elif Input.is_action_just_pressed("weapon3"):
		spawn_weapon(2)
	elif Input.is_action_just_pressed("weapon4"):
		spawn_weapon(3)
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.z -= 1
	if Input.is_action_pressed("move_left"):
		direction.z += 1
	if Input.is_action_pressed("move_down"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.x -= 1	
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(direction)
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)

		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# If the collider is with a mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			# we check that we are hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.8:
				print(Vector3.UP.dot(collision.get_normal()))
				# If so, we squash it and bounce.
				mob.squash()
				target_velocity.y = bounce_impulse
				# Prevent further duplicate calls.
				break

	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func die():
	on_death.emit()
	queue_free()

func spawn_weapon(index):
	if index < 0 || index > weapons.size():
		pass

	var weapon = weapons[index].visuals_3d.instantiate()
	weapon.on_kill.connect(on_kill)
	add_child(weapon)
	weapon.initialize(level, position)

func _on_mob_detector_body_entered(body):
	health -= 1
	if health <= 0:
		die()
	else:
		on_hit.emit(health)

func on_kill():
	experience += 1
	if experience > 10:
		level += 1
		experience = 0
		on_get_level.emit(level)
	on_get_experience.emit(experience)

func add_weapon(item: Item):
	weapons.append(item)
