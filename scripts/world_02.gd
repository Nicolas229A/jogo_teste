extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://actors/player.tscn")

@onready var camera := $camera as Camera2D
@onready var control: Control = $HUD/control as Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_dead.connect(reload_game)
	control.time_is_up.connect(reload_game)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func reload_game():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_dead.connect(reload_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3	
	Globals.respawn_player()
	#get_tree().reload_current_scene()
	
