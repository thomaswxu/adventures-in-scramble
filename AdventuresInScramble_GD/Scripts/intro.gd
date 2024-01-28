extends CanvasLayer

const NUM_IMAGES = 3
var current_image = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	current_image += 1
	if current_image <= NUM_IMAGES:
		$TextureRect.texture = load("res://Assets/Intro" + str(current_image) + ".png")
	else:
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
