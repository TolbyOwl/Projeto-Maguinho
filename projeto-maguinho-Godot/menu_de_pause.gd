extends Control

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()



func _on_button_pressed() -> void:
	resume()


func _on_button_2_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_button_3_pressed() -> void:
	get_tree().quit()
