extends Node2D

@export var minSize := 1.0        # Will be the original scale of the object
@export var maxSize := 9.0        # Will be the max scale of the object

var sizePercentage := 1.0
var animationRate := 1.0

func _ready():
	minSize = scale.y
	maxSize = minSize * maxSize
	sizePercentage = scale.y * 100 / maxSize
	
	$BlinkTimerL.wait_time = randi() % 15 + 5
	$BlinkTimerL.start()
	
	$BlinkTimerR.wait_time = randi() % 15 + 5
	$BlinkTimerR.start()
	
	$MlemTimer.wait_time = randi() % 25 + 10
	$MlemTimer.start()

func _physics_process(delta):
	if scale.y < maxSize:
		scale += Vector2(.001, .001)
		sizePercentage = scale.y * 100 / maxSize
	else:
		scale = Vector2(maxSize, maxSize)
	animationRate = 1.1 - (sizePercentage/125)

func _on_blink_l_timer_timeout():
	$EyeL.animation = "Blink"
	$EyeL.speed_scale = animationRate
	$EyeL.play()

func _on_eye_l_animation_finished():
	$EyeL.animation = "Idle"
	$EyeL.play()
	
	$BlinkTimerL.wait_time = randi() % 15 + 5
	$BlinkTimerL.wait_time += sizePercentage/50
	$BlinkTimerL.start()

func _on_blink_r_timer_timeout():
	$EyeR.animation = "Blink"
	$EyeR.speed_scale = animationRate
	$EyeR.play()

func _on_eye_r_animation_finished():
	$EyeR.animation = "Idle"
	$EyeR.play()
	
	$BlinkTimerR.wait_time = randi() % 15 + 5
	$BlinkTimerR.wait_time += sizePercentage/50
	$BlinkTimerR.start()

func _on_mlem_timer_timeout():
	$Mouth.animation = "Mlem"
	$Mouth.speed_scale = animationRate
	$Mouth.play()

func _on_mouth_animation_finished():
	$Mouth.animation = "Idle"
	$Mouth.play()
	
	$MlemTimer.wait_time = randi() % 20 + 10
	$MlemTimer.wait_time += sizePercentage/50
	$MlemTimer.start()
