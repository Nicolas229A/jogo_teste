extends EnemyBase

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
