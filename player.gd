extends CharacterBody2D


@export var SPEED: float = 300.0
@export var player_id: String = "1"
var weapon: Node2D
var health: int = 1
@onready var player_collider := $CollisionShape2D
@onready var player_sprite := $Sprite2D

var dagger = preload("res://dagger.tscn")

func _ready() -> void:
	set_weapon(dagger)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack_p"+player_id):
		weapon.attack()

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_x := Input.get_axis("left_p"+player_id, "right_p"+player_id)
	var input_y := Input.get_axis("up_p"+player_id, "down_p"+player_id)
	var direction = Vector2(input_x, input_y).normalized()
	if direction.length() > 0:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	look_at(get_global_mouse_position())
	move_and_slide()

func set_weapon(weapon_type: PackedScene) -> void:
	if weapon:
		weapon.queue_free()
		weapon = null
	var weapon_instance = weapon_type.instantiate()
	add_child(weapon_instance)
	weapon = weapon_instance

func damage() -> void:
	player_sprite.modulate = Color.RED
	health -= 1
