extends Node2D

@export var minSize := 1.0        # Will be the original scale of the object
@export var maxSize := 10.0       # Will be the max scale of the object

func _ready():
	minSize = scale.x
	maxSize = minSize * maxSize
