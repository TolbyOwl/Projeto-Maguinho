extends Node2D

func _ready() -> void:
	for dado in ScriptGlobal.pegar_dados_ranking():
		$ColorRect/Ranking.add_item(dado)
	

func iniciar_jogo() -> void:
	var nome = $ColorRect/TextEditNome.text
	ScriptGlobal.iniciar_jogo(nome)
