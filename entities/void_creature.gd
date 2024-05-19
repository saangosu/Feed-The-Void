extends Node2D

@export var minSize := 1.0        # Will be the original scale of the object
@export var maxSize := 9.0        # Will be the max scale of the object

var sizePercentage := 1.0
var animationRate := 1.0
var food_value := 0
var has_won = false

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


func _process(delta):
	if CustomGlobal.isCooking:
		CustomGlobal.isCooking = false
		food_value = CustomGlobal.ingredients_value
		$Mouth.play("Nom")
		$NommingAudio.play()
		$EatingTimer.start()


func _physics_process(delta):
	if !CustomGlobal.has_won:
		if food_value > 0:
			if scale.y < maxSize:
				if !$GrowAudio.playing:
					$GrowAudio.play()
				scale += Vector2(.006, .006)
				food_value -= 0.2
				sizePercentage = scale.y * 100 / maxSize
			else:
				CustomGlobal.has_won = true
			animationRate = 1.1 - (sizePercentage/125)
		if food_value < 0:
			if food_value+0.2 >=0:
				food_value = 0
			elif scale.y > minSize:
				if !$ShrinkAudio.playing:
					$ShrinkAudio.play()
				scale -= Vector2(.006, .006)
				food_value += 0.2
				sizePercentage = scale.y * 100 / maxSize
			else:
				scale = Vector2(minSize, minSize)
	elif !has_won:
		has_won = true
		print("User won!")
	else:
		scale += Vector2(.5, .5)


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
	if !$Mouth.is_playing():
		$Mouth.speed_scale = animationRate
		$Mouth.play("Mlem")


func _on_mouth_animation_finished():
	$Mouth.animation = "Idle"
	$Mouth.play()
	
	$MlemTimer.wait_time = randi() % 20 + 10
	$MlemTimer.wait_time += sizePercentage/50
	$MlemTimer.start()


func _on_eating_timer_timeout():
	CustomGlobal.resetPot()
