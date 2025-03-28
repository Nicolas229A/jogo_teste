extends Area2D

var is_active = false

@onready var animation: AnimatedSprite2D = $animation

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player" or is_active:
		return
	activate_checkpoint()

func activate_checkpoint():
	Globals.current_checkpoint = self
	animation.play("raising")
	is_active = true
	
func _on_animation_animation_finished() -> void:
	if animation.animation == "raising":
		animation.play("checked")
