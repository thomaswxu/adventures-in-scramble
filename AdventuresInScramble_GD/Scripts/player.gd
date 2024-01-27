extends CharacterBody2D

# Constants
const STARTING_LIVES = 3
const SPEED = 500.0
const JUMP_VELOCITY = -600.0
const FAST_FALL_VELOCITY = 2000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # 980, dir (0, 1)

var lives_left = STARTING_LIVES

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("fast_fall") and not is_on_floor():
		velocity.y = FAST_FALL_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# What to do when hit by an obstacle
func handle_obstacle_hit():
	lives_left -= 1
	if lives_left == 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
