extends RigidBody2D

var can_hurt: bool = true

func _physics_process(delta: float) -> void:
	if linear_velocity.length() < 100:
		can_hurt = false

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if can_hurt:
		if body.is_in_group("Damagable"):
			body.damage()
	else:
		if body.is_in_group("Player"):
			if body.pickup_arrow():
				queue_free()
	
