extends CanvasLayer

@onready var back_btn: Button = $menu_holder/back_btn

func _ready() -> void:
	visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = false
		get_parent().visible = true

func _on_back_btn_pressed() -> void:
	visible = false
	get_parent().visible = true
