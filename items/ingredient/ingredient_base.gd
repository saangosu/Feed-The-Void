extends Node2D

@export var image: Texture
@export var label: String
@export var ingredient_destination: Marker2D
@export var move_speed := 800

var ingredient_moving: Node2D

var is_moving := false

const new_x = 64
const new_y = 64


# NATIVE METHODS
func _ready():
	if image:
		var texture = ImageTexture.create_from_image(Image.load_from_file(image.resource_path))
		texture.set_size_override(Vector2i(new_x, new_y))
		$Sprite2D.texture = texture
	
	if label:
		$Anchor/Label.text = label
		$Anchor/Label.size = Vector2(new_x, $Anchor/Label.size.y)
		$Anchor.position.x = -new_x / 2
		$Anchor.position.y = new_y / 2
	
	$Area2D/CollisionShape2D.position = Vector2(0, new_y*0.125)
	$Area2D/CollisionShape2D.shape.size = Vector2(new_x, new_y*1.25)


func _process(delta):
	move_to_cooking_pot(delta)


# METHODS
func set_ingredient_moving():
	var scene = load("res://items/ingredient/ingredient_moving.tscn")
	ingredient_moving = scene.instantiate()
	ingredient_moving.global_position = $Sprite2D.global_position
	ingredient_moving.texture = $Sprite2D.texture
	self.get_owner().add_child(ingredient_moving)


func move_to_cooking_pot(delta: float):
	if is_moving:
		ingredient_moving.global_position = ingredient_moving.global_position.move_toward(ingredient_destination.global_position, delta*move_speed)
		print(ingredient_moving.global_position)
	if ingredient_moving != null && ingredient_moving.global_position == ingredient_destination.global_position:
		is_moving = false
		ingredient_moving.queue_free()


# SIGNALS
func _on_area_2d_input_event(viewport, event, shape_idx):
	if ingredient_destination:
		if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if !is_moving:
				set_ingredient_moving()
				is_moving = true


func _on_area_2d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_area_2d_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)