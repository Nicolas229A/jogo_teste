extends EnemyBase

@onready var spawn_enemy: Marker2D = $"../spawn_enemy"

func _ready() -> void:
	spawn_instance = preload("res://actors/cherry.tscn")
	spawn_instance_position = spawn_enemy
	can_spawn = true
	animation.animation_finished.connect(kill_air_enemy)

#func _on_hitbox_body_entered(body: Node2D) -> void:
	#animation.play("hurt")
	
