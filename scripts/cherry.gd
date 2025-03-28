extends EnemyBase

func _ready() -> void:
	animation.animation_finished.connect(kill_ground_enemy_2)

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
