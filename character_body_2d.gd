extends CharacterBody2D


@export var SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_x := Input.get_axis("left", "right")
	var input_y := Input.get_axis("up", "down")
	var direction = Vector2(input_x, input_y).normalized()
	if direction.length() > 0:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	look_at(get_global_mouse_position())
	move_and_slide()
