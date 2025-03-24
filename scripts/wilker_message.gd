extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_wilker: Area2D = $area_wilker

const lines: Array[String] = [
	"Salve meu mano!",
	"Que tu tá fazendo aqui?",
	"O que eu tô fazendo aqui??",
	"FEDENDO BABE!!",
]

func _unhandled_input(event: InputEvent) -> void:
	if area_wilker.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
