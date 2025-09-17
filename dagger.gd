extends Node2D


var starting_position: Vector2
var target_position: Vector2
var attacking: bool = false
var t: float = 0

func _physics_process(delta: float) -> void:
	if attacking:
		if t < 1.0:
			t += 5*delta
			position = starting_position.lerp(target_position, t)
		elif t < 2.0:
			t += 8*delta
			position = target_position.lerp(starting_position, t-1.0)
		else:
			position = starting_position
			attacking = false

func attack() -> void:
	if attacking:
		return
	starting_position = position
	target_position = starting_position+Vector2(40, 0)
	t = 0
	attacking = true


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Damagable"):
		body.damage()
