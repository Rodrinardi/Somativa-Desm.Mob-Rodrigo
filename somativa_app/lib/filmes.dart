import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Filmes extends StatefulWidget {
  const Filmes({super.key});

  @override
  State<Filmes> createState() => _FilmesState();
}

class _FilmesState extends State<Filmes> {
  List filmes = <FilmesItens>[];
  _exibefilme()async{
    String url = "https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json";
    //String url = "http://10.109.83.04:3000/filmes";
    http.Response resposta = await http.get(Uri.parse(url));
     
    List dado = json.decode(resposta.body) as List; 
    print(dado);
    setState(() {
      filmes = dado.map((json) => FilmesItens.fromJson(json)).toList(); 
    });
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Streaming de Filmes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Column(
                  children: filmes.map((filme) => Text(
                          "${filme.nome} - R\$ ${filme.imagem} - ${filme.duracao} - ${filme.ano_de_lancamento} - ${filme.nota}",
                          style: TextStyle(fontSize: 18))).toList(),
                ),
            ElevatedButton(onPressed: _exibefilme, child: Text("Exibir")),
            
            
      
          ],
        ),
      ),
    );
  }
}

class FilmesItens{
  

  String nome;
  String imagem;
  String duracao;
  String ano_de_lancamento;
  String nota;
  FilmesItens(this.nome, this.imagem, this.duracao, this.ano_de_lancamento, this.nota); // construtor da classe produto
  factory FilmesItens.fromJson(Map<String,dynamic>json){
    return FilmesItens(json["nome"],json["imagem"],json["duração"], json["ano de lançamento"], json["nota"]);
  }
}