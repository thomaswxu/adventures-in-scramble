extends Area2D

const RETURN_DRIFT_SPEED = 700
const RETURN_POINT_DIST_TOLERANCE = 100 # Within this dist to return point, stop drifting towards it
const ATTACK_DURATION_s = 0.6
const ATTACK_WARNING_DURATION_s = 0.5

var return_point = Vector2(0, 0) # Boss will always naturally drift back to this point.
var return_velocity = Vector2(0, 0)
var attack_velocity = Vector2(0, 0)

# Used for attack velocity calculations, not directly used as velocity
var attack_vel_x = 0
var attack_vel_y = 0

var player
var warning_arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = get_parent().get_node("Player")
	warning_arrow = $Arrow
	warning_arrow.visible = false
	$AttackDurationTimer.wait_time = ATTACK_DURATION_s
	$AttackWarningTimer.wait_time = ATTACK_WARNING_DURATION_s

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(return_point) > RETURN_POINT_DIST_TOLERANCE:
		return_velocity = position.direction_to(return_point).normalized() * RETURN_DRIFT_SPEED
	else:
		return_velocity = Vector2(0, 0)
	position += delta * (return_velocity + attack_velocity)

func set_return_point(return_pt: Vector2):
	return_point = return_pt

func start_attack():
	# Compute attack velocity
	attack_vel_x = randf_range(-500, 500)
	attack_vel_y = 1300

	# Compute attack direction vector for warning arrow
	var attack_height_estimate = 600
	var attack_angle_rad = atan2(attack_vel_x, attack_height_estimate)
	warning_arrow.rotation = attack_angle_rad - PI / 2
	warning_arrow.visible = true
	$AttackWarningTimer.start()

func attack_down():
	attack_velocity.x = attack_vel_x
	attack_velocity.y = attack_vel_y
	$AttackDurationTimer.start()

func _on_body_entered(body):
	if "Player" in body.name:
		print("Player entered/touched obstacle: " + name)
		player.handle_obstacle_hit()

# Function is called when an attack finishes its allotted time.
func _on_attack_duration_timer_timeout():
	attack_velocity = Vector2(0, 0)

func _on_attack_warning_timer_timeout():
	warning_arrow.visible = false
	attack_down()
