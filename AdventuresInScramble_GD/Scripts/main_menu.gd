extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$SoundPlayer.playing = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")

func _on_quit_button_pressed():
	$SoundPlayer.playing = true
	#get_tree().quit()
	pass

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
