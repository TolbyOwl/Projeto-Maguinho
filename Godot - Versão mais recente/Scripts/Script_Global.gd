extends Node

var Maguin1 = null
var Vida = null
var Pontos = 0
var Bats = 0
var Too_many_bats = false
var nome_jogador;
var banco_de_dados = "";
var bd = null

func _ready() -> void:
	bd = SQLite.new()
	bd.path = "banco_de_dados.db"
	bd.open_db()
	var sql = "create table IF NOT EXISTS jogador(id integer primary key autoincrement, nome text, pontuacao integer)"
	bd.query(sql)

func _process(delta: float) -> void:
	_controlar_qtd_morcegos()

func _controlar_qtd_morcegos():
	if Bats > 3:
		Too_many_bats = true
	else:
		Too_many_bats = false

func salvar_resultado():
	var sql = "insert into jogador(nome, pontuacao) values('" + str(nome_jogador) + "'," + str(Pontos) + ")"
	bd.query(sql)

func pegar_dados_ranking():
	var dados = ""
	var sql   = "select * from jogador"
	bd.query(sql)
	var tabela = bd.query_result
	for linha in tabela:
		dados += str(linha["nome"]) + " - " + str(linha["pontuacao"]) + "\n"
	return dados

func iniciar_jogo(nome):
	nome_jogador = nome;
	Pontos = 0;
	get_tree().change_scene_to_file("res://Cenas/Cena_Cenario1.tscn")

func registrar_pontuacao():
	banco_de_dados += nome_jogador + " - " +str(Pontos) + "\n";
