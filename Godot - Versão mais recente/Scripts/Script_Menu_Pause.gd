extends Control

@onready var menuPause = self
var paused = false

func _ready() -> void:
	_pausar_resumir()
func _process(delta):
	testEsc()
	_pausar_resumir()

func _pausar_resumir():
	if paused:
		menuPause.show()
		Engine.time_scale = 0
	else:
		menuPause.hide()
		Engine.time_scale = 1

func testEsc():
	if Input.is_action_just_pressed("ui_text_clear_carets_and_selection") and !paused:
		paused = true
	elif Input.is_action_just_pressed("ui_text_clear_carets_and_selection") and paused:
		paused = false

func _on_button_pressed() -> void:
	paused = false

func _on_button_2_pressed() -> void:
	paused = false
	get_tree().reload_current_scene()

func _on_button_3_pressed() -> void:
	get_tree().quit()
