extends CanvasLayer

@onready var Status = $AnimationPlayer

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
			
