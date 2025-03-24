extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var animation := $animation as AnimationPlayer

@export var enemy_score := 100

var direction := -1

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
		
	velocity.x = direction * SPEED * delta

	move_and_slide()



func _on_animation_animation_finished(animation_name: StringName) -> void:
	if animation_name == "hurt":
		Globals.score += enemy_score
		queue_free()
