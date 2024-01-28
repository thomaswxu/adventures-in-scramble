extends Node2D

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = $Player
	$Interface/LivesPanelContainer/MarginContainer/GridContainer/LivesLabel.text = str(player.lives_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
