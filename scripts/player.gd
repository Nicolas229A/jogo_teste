extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -400.0

@onready var animation := $animation as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D 

var is_jumping := false
var knockback_vector := Vector2.ZERO 
var knockback_power := 20

signal player_dead()

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("ui_up") and is_on_floor(): #just
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
		elif is_jumping:
			animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
		

func _on_hurtbox_body_entered(body: Node2D) -> void:
		var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -200)
		print(knockback)
		take_damage(knockback)
		
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path 

func take_damage(knockback_force):
	if Globals.player_life > 0:
		Globals.player_life -= 1
		knockback(knockback_force)
		print("-1 ponto de vida, VIDA: ", Globals.player_life)
	else:
		queue_free()
		emit_signal("player_dead")
		
func knockback (knockback_force := Vector2.ZERO, duration := 0.25):
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		print("Knockback tem força")
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1, 0, 0, 1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1, 1, 1, 1), duration)
		print("Tomou o dano")
		
func _on_head_collider_body_entered(body: Node2D) -> void:
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			body.create_coin()
