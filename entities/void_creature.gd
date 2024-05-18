extends Node2D

@export var minSize := 1.0        # Will be the original scale of the object
@export var maxSize := 9.0       # Will be the max scale of the object
var sizePercentage := 1.0

func _ready():
	minSize = scale.y
	maxSize = minSize * maxSize
	sizePercentage = scale.y * 100 / maxSize

func _on_blink_timer_timeout():
	$EyeL.animation = "Blink"
	$EyeL.play()

func _physics_process(delta):
	print(scale.y < maxSize)
	if scale.y < maxSize:
		scale *= Vector2(1.5, 1.5)
		sizePercentage = scale.y * 100 / maxSize


func _on_eye_l_animation_finished():
	$EyeL.animation = "Idle"
	$EyeL.speed_scale = 1.0
	$EyeL.play()
