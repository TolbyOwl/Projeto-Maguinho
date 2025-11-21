extends TileMapLayer

func _ready() -> void:
	ScriptGlobal.Maguin1 = $Maguin
	ScriptGlobal.Vida = 6
	ScriptGlobal.Pontos = 0
	#var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego.tscn")
	#var Instance_Morcego = Morcego.instantiate()
	#add_child(Instance_Morcego)
	#Instance_Morcego.global_position = $Spawn_1.global_position

func _process(delta: float) -> void:
	if ScriptGlobal.Too_many_bats:
		$Controle_Spawn.stop()
	elif $Controle_Spawn.is_stopped():
		$Controle_Spawn.start()

func _on_timer_timeout() -> void:
		_invoca_morcego()

func _invoca_morcego():
	var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego.tscn")
	var Instance_Morcego = Morcego.instantiate()
	add_child(Instance_Morcego)
	ScriptGlobal.Bats += 1
