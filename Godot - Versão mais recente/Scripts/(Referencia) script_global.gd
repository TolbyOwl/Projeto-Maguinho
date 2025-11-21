extends Node

var nome_jogador;
var pontos_jogador;
var banco_de_dados = "";

var bd = null
func _ready() -> void:
	bd = SQLite.new()
	bd.path = "banco_de_dados.db"
	bd.open_db()
	var sql = "create table IF NOT EXISTS jogador(id integer primary key autoincrement, nome text, pontuacao integer)"
	bd.query(sql)

func salvar_resultado():
	var sql = "insert into jogador(nome, pontuacao) values('" + str(nome_jogador) + "'," + str(pontos_jogador) + ")"
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
	pontos_jogador = 0;
	get_tree().change_scene_to_file("res://cena_fase.tscn")

func registrar_pontuacao():
	banco_de_dados += nome_jogador + " - " +str(pontos_jogador) + "\n";
	

		
