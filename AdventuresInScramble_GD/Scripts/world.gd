extends Node2D

const MIN_OBSTACLE_SPAWN_DELAY_s = 0.5
const MAX_OBSTACLE_SPAWN_DELAY_s = 2.0

var obstacle_scene = preload("res://Scenes/obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$ObstacleSpawnTimer.wait_time = get_obstacle_spawn_timeout()
	$ObstacleSpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
