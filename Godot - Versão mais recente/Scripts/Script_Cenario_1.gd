extends TileMapLayer

func _ready() -> void:
	ScriptGlobal.Maguin1 = $Maguin
	ScriptGlobal.Vida = 6
	ScriptGlobal.Pontos = 0
	$AudioStreamPlayer.play()
	#var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego.tscn")
	#var Instance_Morcego = Morcego.instantiate()
	#add_child(Instance_Morcego)
	#Instance_Morcego.global_position = $Spawn_1.global_position

func _process(delta: float) -> void:
	if ScriptGlobal.Too_many_bats:
		$Controle_Spawn_Morcego.stop()
	elif $Controle_Spawn_Morcego.is_stopped():
		$Controle_Spawn_Morcego.start()
	
	if ScriptGlobal.Too_many_slimes:
		$Controle_Spawn_Slime.stop()
	elif $Controle_Spawn_Slime.is_stopped():
		$Controle_Spawn_Slime.start()

func _invoca_morcego():
	var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego.tscn")
	var Instance_Morcego = Morcego.instantiate()
	add_child(Instance_Morcego)
	ScriptGlobal.Bats += 1
	print(str(Morcego))

func _invoca_morcego_fogo():
	var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego_Fogo.tscn")
	var Instance_Morcego = Morcego.instantiate()
	add_child(Instance_Morcego)
	Instance_Morcego.global_position = $Spawn_1.global_position
	ScriptGlobal.Bats += 1
	print(str(Morcego))

func _invoca_morcego_gelo():
	var Morcego = preload("res://Cenas/Cena_Inimigo_Morcego_Gelo.tscn")
	var Instance_Morcego = Morcego.instantiate()
	add_child(Instance_Morcego)
	Instance_Morcego.global_position = $Spawn_2.global_position
	ScriptGlobal.Bats += 1
	print(str(Morcego))

func _invoca_slime():
	var Slime = preload("res://Cenas/Cena_Inimigo_Slime.tscn")
	var Instance_Slime = Slime.instantiate()
	add_child(Instance_Slime)
	Instance_Slime.global_position = $Spawn_3.global_position
	ScriptGlobal.Slimes += 1
	print(str(Slime))

func _invoca_slime_fogo():
	var Slime = preload("res://Cenas/Cena_Inimigo_Slime_Fogo.tscn")
	var Instance_Slime = Slime.instantiate()
	add_child(Instance_Slime)
	Instance_Slime.global_position = $Spawn_4.global_position
	ScriptGlobal.Slimes += 1
	print(str(Slime))

func _invoca_slime_gelo():
	var Slime = preload("res://Cenas/Cena_Inimigo_Slime_Gelo.tscn")
	var Instance_Slime = Slime.instantiate()
	add_child(Instance_Slime)
	Instance_Slime.global_position = $Spawn_5.global_position
	ScriptGlobal.Slimes += 1
	print(str(Slime))


func _on_timer_timeout() -> void:
	randomize()
	var morcego = [self._invoca_morcego,self._invoca_morcego_gelo,self._invoca_morcego_fogo]
	morcego.pick_random().call()

func _on_controle_spawn_slime_timeout() -> void:
	randomize()
	var slime = [self._invoca_slime, self._invoca_slime_gelo, self._invoca_slime_fogo]
	slime.pick_random().call()
