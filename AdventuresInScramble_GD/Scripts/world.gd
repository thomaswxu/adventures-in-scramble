extends Node2D

const POT_HEIGHT = 2000
const MIN_OBSTACLE_SPAWN_DELAY_s = 0.2
const MAX_OBSTACLE_SPAWN_DELAY_s = 0.8

const PLATFORM_CENTER_MIN_X = 0
const PLATFORM_CENTER_MAX_X = 1500 # 1675
const PLATFORM_MAX_ROT_rad = 0.2
const PLATFORM_MAX_X_SCALE = 7
const PLATFORM_MIN_X_SCALE = 1
const PLATFORM_MAX_Y_INTERVAL = 140
const PLATFORM_MIN_Y_INTERVAL = 100
const RANDOM_PLAT_START_HEIGHT = 400

var obstacle_scene = preload("res://Scenes/obstacle.tscn")
var random_platform_scene = preload("res://Scenes/random_platform.tscn")

var distance_to_top_label
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = $Player
	
	# Set initial state of interface elements
	$Interface/LivesPanelContainer/MarginContainer/GridContainer/LivesLabel.text = str(player.lives_left)
	distance_to_top_label = $Interface/DistancePanelContainer/MarginContainer/GridContainer/DistLabel
	
	# Set up obstacle spawn timer
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	$ObstacleSpawnTimer.start()
	
	spawn_platforms()
	
	$AudioStreamPlayer.playing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update interface elements
	update_distance_to_top()
	if player.position.y < -POT_HEIGHT:
		get_tree().change_scene_to_file.bind("res://Scenes/boss1_intro.tscn").call_deferred()

func spawn_obstacle():
	var obstacle_instance = obstacle_scene.instantiate()
	add_child(obstacle_instance)

func _on_obstacle_spawn_timer_timeout():
	spawn_obstacle()
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	#print("Changed obstacle spawn timer wait time to: " + str($ObstacleSpawnTimer.wait_time))

# Get a random obstacle spawn timeout, within the min/max parameters above
func get_obstacle_spawn_timeout() -> float:
	return randf_range(MIN_OBSTACLE_SPAWN_DELAY_s, MAX_OBSTACLE_SPAWN_DELAY_s)

# Update the "distance to top" UI label
func update_distance_to_top():
	distance_to_top_label.text = str(int(POT_HEIGHT + player.position.y))

# Spawn random platforms all the way to the top
func spawn_platforms():
	var platform_y = RANDOM_PLAT_START_HEIGHT
	while platform_y > -POT_HEIGHT:
		var platform_instance = random_platform_scene.instantiate()

		platform_instance.scale.x = randf_range(PLATFORM_MIN_X_SCALE, PLATFORM_MAX_X_SCALE)
		platform_instance.rotation = randf_range(-PLATFORM_MAX_ROT_rad, PLATFORM_MAX_ROT_rad)
		
		var platform_x = randf_range(PLATFORM_CENTER_MIN_X, PLATFORM_CENTER_MAX_X)
		platform_instance.position = Vector2(platform_x, platform_y)
		
		add_child(platform_instance)
		
		platform_y -= randf_range(PLATFORM_MIN_Y_INTERVAL, PLATFORM_MAX_Y_INTERVAL)
