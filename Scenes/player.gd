extends CharacterBody2D

@export var SPEED = 500.0
var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# 读取输入
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector = input_vector.normalized()

	# 更新 velocity
	velocity = input_vector * SPEED

	# 移动角色
	move_and_slide()  # Godot 4 会自动使用 velocity

	# 更新动画
	_update_animation(velocity)


func _update_animation(velocity: Vector2) -> void:
	if velocity == Vector2.ZERO:
		sprite.play("idle")
		return

	# 根据速度方向播放动画
	if abs(velocity.x) > abs(velocity.y):
		sprite.animation = "Left_walk" if velocity.x < 0 else "Right_walk"
	else:
		sprite.animation = "Down_walk" if velocity.y < 0 else "Up_walk"
