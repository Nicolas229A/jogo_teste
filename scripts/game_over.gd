extends Control

func _ready() -> void:
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3	

func _process(delta: float) -> void:
	pass


func _on_restart_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit() 
