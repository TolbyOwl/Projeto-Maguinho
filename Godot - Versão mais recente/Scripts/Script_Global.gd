extends Node

var Maguin1 = null
var Vida = null
var Bats = 0
var Too_many_bats = false

func _process(delta: float) -> void:
	_controlar_qtd_morcegos()


func _controlar_qtd_morcegos():
	if Bats > 3:
		Too_many_bats = true
	else:
		Too_many_bats = false
