extends Area2D

const FALL_GRAVITY = 1000
const LAUNCH_SPEED = 1000
const KILL_HEIGHT = 1000

var player = null
var velocity = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = get_parent().get_node("Player")
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	velocity.y += FALL_GRAVITY * delta
	
	if position.y > KILL_HEIGHT:
		queue_free()

# Spawn with random:
# - Position relative to the player
# - Initial velocity
func spawn():
	# Randomize starting position offsets
	var spawn_on_left = randi_range(0, 1)
	var x_offset = 1000
	if (spawn_on_left):
		x_offset *= -1
	var y_offset = randf_range(-300, -700)
	position = player.position + Vector2(x_offset, y_offset)

	# Randomize initial velocity
	var initial_velocity_angle = 0.0
	if (spawn_on_left):
		initial_velocity_angle = randf_range(0, -PI / 2.0)
	else:
		initial_velocity_angle = randf_range(-PI / 2.0, -PI)
	velocity = LAUNCH_SPEED * Vector2(cos(initial_velocity_angle), sin(initial_velocity_angle))
	#print("Obstacle spawned, velocity = (" + str(velocity[0]) + ", " + str(velocity[1]) + ")")

func _on_body_entered(body):
	if "Player" in body.name:
		print("Player entered/touched obstacle: " + name)
		player.handle_obstacle_hit()
