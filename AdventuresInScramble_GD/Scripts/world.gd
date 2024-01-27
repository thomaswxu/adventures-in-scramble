extends Node2D

var obstacle_scene = preload("res://Scenes/obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_obstacle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_obstacle():
	var obstacle_instance = obstacle_scene.instantiate()
	add_child(obstacle_instance)
