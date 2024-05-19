extends Node2D

var opacity = 1

func _ready():
	CustomGlobal.resetEverything()


func _process(delta):
	if CustomGlobal.has_won:
		if opacity > 0:
			opacity -= 0.005
			$IngredientsScatter.modulate.a = opacity
			$CookingPot.modulate.a = opacity
			$EndScreen.modulate.a = 1-opacity


func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/main.tscn")
