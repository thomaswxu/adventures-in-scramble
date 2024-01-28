extends Area2D

const RETURN_DRIFT_SPEED = 700
const RETURN_POINT_DIST_TOLERANCE = 100 # Within this dist to return point, stop drifting towards it
const ATTACK_DURATION_s = 0.8
const ATTACK_DOWN_VELOCITY = Vector2(200, 1000)

var return_point = Vector2(0, 0) # Boss will always naturally drift back to this point.
var return_velocity = Vector2(0, 0)
var attack_velocity = Vector2(0, 0)

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = get_parent().get_node("Player")
	$AttackDurationTimer.wait_time = ATTACK_DURATION_s

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(return_point) > RETURN_POINT_DIST_TOLERANCE:
		return_velocity = position.direction_to(return_point).normalized() * RETURN_DRIFT_SPEED
	else:
		return_velocity = Vector2(0, 0)
	position += delta * (return_velocity + attack_velocity)

func set_return_point(return_pt: Vector2):
	return_point = return_pt
	
func attack_down():
	attack_velocity = ATTACK_DOWN_VELOCITY
	$AttackDurationTimer.start()

# Function is called when an attack finishes its allotted time.
func _on_attack_duration_timer_timeout():
	attack_velocity = Vector2(0, 0)

func _on_body_entered(body):
	if "Player" in body.name:
		print("Player entered/touched obstacle: " + name)
		player.handle_obstacle_hit()
