extends Node2D

func _ready() -> void:
	$ColorRect/Ranking.add_item(ScriptGlobal.pegar_dados_ranking())
	

func iniciar_jogo() -> void:
	var nome = $ColorRect/TextEditNome.text
	ScriptGlobal.iniciar_jogo(nome)
