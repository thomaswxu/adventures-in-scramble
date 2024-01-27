extends Node2D

const POT_HEIGHT = 1000
const MIN_OBSTACLE_SPAWN_DELAY_s = 0.5
const MAX_OBSTACLE_SPAWN_DELAY_s = 2.0

var obstacle_scene = preload("res://Scenes/obstacle.tscn")

var distance_to_top_label
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	# Set initial state of interface elements
	$Interface/LivesPanelContainer/MarginContainer/GridContainer/LivesLabel.text = str($Player.lives_left)
	distance_to_top_label = $Interface/DistancePanelContainer/MarginContainer/GridContainer/DistLabel
	
	# Set up obstacle spawn timer
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	$ObstacleSpawnTimer.start()
	
	player = $Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update interface elements
	update_distance_to_top()

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
