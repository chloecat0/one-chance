extends CharacterBody2D


@export var SPEED: float = 300.0
@export var ROTATE_SPEED: float = 0.04
@export var player_id: String = "1"
var weapon: Node2D
var health: int = 1
@onready var player_collider := $CollisionShape2D
@export var player_texture: CompressedTexture2D
@onready var player_sprite := $Sprite2D
@export var target := Node2D

@onready var death_timer := $DeathTimer

var dagger = preload("res://dagger.tscn")
var bow = preload('res://bow.tscn')

func _ready() -> void:
	set_weapon(bow)
	player_sprite.texture = player_texture

func _process(delta: float) -> void:
	if health <= 0:
		return
	if Input.is_action_just_pressed("attack_p"+player_id):
		weapon.attack()

func _physics_process(delta: float) -> void:
	if health <= 0:
		return
	var input_x := Input.get_axis("left_p"+player_id, "right_p"+player_id)
	var input_y := Input.get_axis("up_p"+player_id, "down_p"+player_id)
	var direction = Vector2(input_x, input_y).normalized()
	if direction.length() > 0:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if target:
		rotation = rotate_toward(rotation, rotation+get_angle_to(target.global_position), ROTATE_SPEED)
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
	if health <= 0:
		death_timer.start()

func pickup_arrow() -> bool:
	if weapon.name == "Bow":
		if !weapon.arrow:
			weapon.arrow = true
			return true
	return false

func revive() -> void:
	health = 1
	player_sprite.modulate = Color.WHITE
	if weapon.name == "Bow":
		weapon.arrow = true
	get_node("/root/Main").move_to_random_spawn(player_id, null)
