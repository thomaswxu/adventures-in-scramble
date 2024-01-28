extends Node2D

const PLATE_X = 13000

const MIN_OBSTACLE_SPAWN_DELAY_s = 0.3
const MAX_OBSTACLE_SPAWN_DELAY_s = 0.6
const BOSS_PLAYER_OFFSET = Vector2(0, -500)

var player
var boss
var distance_to_plate_label

var obstacle_scene = preload("res://Scenes/obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = $Player
	boss = $Boss1
	$Interface/LivesPanelContainer/MarginContainer/GridContainer/LivesLabel.text = str(player.lives_left)
	distance_to_plate_label = $Interface/DistancePanelContainer/MarginContainer/GridContainer/DistLabel
	
	# Set up obstacle spawn timer
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	$ObstacleSpawnTimer.start()
	
	$BossAttackTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_distance_to_plate()
	boss.set_return_point(player.position + BOSS_PLAYER_OFFSET)

# Update the "distance to plate" UI label
func update_distance_to_plate():
	distance_to_plate_label.text = str(int(PLATE_X - player.position.x))

# Get a random obstacle spawn timeout, within the min/max parameters above
# (Note: ideally change to a reused ObstacleSpawner scene or similar to avoid duplicating code
func get_obstacle_spawn_timeout() -> float:
	return randf_range(MIN_OBSTACLE_SPAWN_DELAY_s, MAX_OBSTACLE_SPAWN_DELAY_s)

func _on_obstacle_spawn_timer_timeout():
	spawn_obstacle()
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	
func spawn_obstacle():
	var obstacle_instance = obstacle_scene.instantiate()
	add_child(obstacle_instance)

func _on_boss_attack_timer_timeout():
	boss.start_attack()
