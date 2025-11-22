extends Control

@onready var menuPause = self
var paused = false

func _ready() -> void:
	menuPause.hide()
	Engine.time_scale = 1
func _process(delta):
	testEsc()

func _pausar_resumir():
	if paused:
		menuPause.show()
		Engine.time_scale = 0
		$AudioStreamPlayer.play()
	else:
		menuPause.hide()
		Engine.time_scale = 1
		$AudioStreamPlayer.play()

func testEsc():
	if Input.is_action_just_pressed("ui_text_clear_carets_and_selection") and !paused:
		paused = true
		_pausar_resumir()
	elif Input.is_action_just_pressed("ui_text_clear_carets_and_selection") and paused:
		paused = false
		_pausar_resumir()

func _on_button_pressed() -> void:
	paused = false
	_pausar_resumir()

func _on_button_2_pressed() -> void:
	paused = false
	_pausar_resumir()
	get_tree().reload_current_scene()

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Cena_Tela_Pontos.tscn")
