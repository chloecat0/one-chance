extends Node2D

@export var arrow_speed: float = 500.0

@export var loaded_texture: CompressedTexture2D
@export var unloaded_texture: CompressedTexture2D

@onready var sprite := $Sprite2D

var arrow: bool = true:
	set(value):
		arrow = value
		update_texture()

var arrow_scene := preload("res://arrow.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_texture()

func attack() -> void:
	if !arrow:
		return
	var arrow_instance = arrow_scene.instantiate()
	
	get_node("/root/Main/HBoxContainer/SubViewportContainer/SubViewport/Map").add_child(arrow_instance)
	arrow_instance.global_position = global_position
	arrow_instance.global_rotation = global_rotation
	arrow_instance.linear_velocity = Vector2.UP.rotated(global_rotation)*arrow_speed
	arrow = false
	update_texture()

func update_texture():
	if arrow:
		sprite.texture = loaded_texture
	else:
		sprite.texture = unloaded_texture
