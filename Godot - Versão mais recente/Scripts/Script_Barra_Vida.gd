extends CanvasLayer

@onready var Status = $AnimationPlayer
@onready var Placar = $Pontuacao

func _process(delta: float) -> void:
	match ScriptGlobal.Vida:
		1:
			Status.play("1")
		2:
			Status.play("2")
		3:
			Status.play("3")
		4:
			Status.play("4")
		5:
			Status.play("5")
		6:
			Status.play("6")
		0:
			Status.play("Morte")
	
	Placar.text = str(ScriptGlobal.Pontos)
	
	#Definir se mostra o mini escudo no topo 
	if ScriptGlobal.Vida_Escudo == 1:
		$Icone_Escudo.visible = true
	else:
		$Icone_Escudo.visible = false


func _on_virtual_joystick_analogic_changed(value: Vector2, distance: float, angle: float, angle_clockwise: float, angle_not_clockwise: float) -> void:
	ScriptGlobal.Joystick = value
