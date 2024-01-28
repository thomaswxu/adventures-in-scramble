extends CanvasLayer

const DEATH_ANIMATION_DELAY_s = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.playing = true
	
	$DeathAnimationTimer.wait_time = DEATH_ANIMATION_DELAY_s
	$DeathAnimationTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_death_animation_timer_timeout():
	$TextureRect.texture = load("res://Assets/shelldon_death 2.png")
