extends CharacterBody2D

@export var speed: float = 150.0

var _target: Vector2 = Vector2.ZERO
var _moving := false

func _ready() -> void:
	add_to_group("player")
	_target = global_position
	_draw_placeholder()

func _draw_placeholder() -> void:
	var rect := ColorRect.new()
	rect.color = Color(0.4, 0.6, 1.0)
	rect.size = Vector2(24, 40)
	rect.position = Vector2(-12, -40)
	add_child(rect)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_on_tap(get_viewport().get_screen_transform().affine_inverse() * event.position)
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_tap(get_viewport().get_canvas_transform().affine_inverse() * event.position)

func _on_tap(world_pos: Vector2) -> void:
	_target = world_pos
	_moving = true

func _physics_process(_delta: float) -> void:
	if not _moving:
		return
	var dir := _target - global_position
	if dir.length() < 4.0:
		velocity = Vector2.ZERO
		_moving = false
	else:
		velocity = dir.normalized() * speed
	move_and_slide()

func disable_movement() -> void:
	_moving = false
	velocity = Vector2.ZERO
	set_physics_process(false)

func enable_movement() -> void:
	set_physics_process(true)
