import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Filmes extends StatefulWidget {
  const Filmes({super.key});

  @override
  State<Filmes> createState() => _FilmesState();
}

class _FilmesState extends State<Filmes> {
  Future<List<FilmesItens>> postsFuture = getPosts();

  // function to fetch data from api and return future list of posts
  static Future<List<FilmesItens>> getPosts() async {
    var url = Uri.parse('https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json');
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => FilmesItens.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Streaming de Filmes"),
      ),
      body: Center(
        child: FutureBuilder<List<FilmesItens>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Color.fromARGB(255, 179, 12, 0),);
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return mostrarFilmes(posts);
            } else {
              // if no data, show simple Text
              return const Text("Nenhum Filme Encontrado!");
            }
          },
        ),
      )
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

Widget mostrarFilmes(List<FilmesItens>filmes){
  return ListView.builder(
    itemCount: filmes.length,
    itemBuilder: (context, index) {
      final filme = filmes[index];
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: MediaQuery.of(context).size.height/5,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 3, color: Colors.black)
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: Image.network(filme.imagem!)),
            SizedBox(width: 10),
            Expanded(flex: 3, child: Container(
              child: ListView(
                children: [
                  Text(filme.nome!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.all(5)),
                  Text('Lançamento: ${filme.ano_de_lancamento!}',style: TextStyle(fontSize: 15),),
                  Text('Duração: ${filme.duracao!}',style: TextStyle(fontSize: 15),),
                  Text('Nota: ${filme.nota!} estrelas',style: TextStyle(fontSize: 15),)
                ],
              ),
            )),
          ],
        ),
      );
    },
  );
}
