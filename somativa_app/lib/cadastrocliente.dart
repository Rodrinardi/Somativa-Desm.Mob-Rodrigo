import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
class Cadastrousuario extends StatefulWidget {
  

  @override
  State<Cadastrousuario> createState() => _CadastrousuarioState();
}
class _CadastrousuarioState extends State<Cadastrousuario> {
  TextEditingController user_n = TextEditingController();
  TextEditingController senha_n = TextEditingController();
  bool exibir = false; 
  _cadastrausuario()async{
    String url = "http://192.168.15.123:3000/usuarios";
    Map<String,dynamic> mensagem = {
      "id": user_n.text,
      "nome":user_n.text,
      "senha": senha_n.text,

    };
    
    http.post(Uri.parse(url),
    headers: <String,String> {
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(mensagem)  );
    
     
    print("Usuario cadastrado");
    user_n.text =""; 
    senha_n.text =""; 
    

    
    }
    
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de usuário"),),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(
              height:300 ,
              width: 300,
              child: Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      icon: Icon(Icons.people_alt_outlined,color: Colors.red,),
                      hintText: "Digite seu nome"),
                      
                      controller: user_n,
                     
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      icon: Icon(Icons.key_outlined,),iconColor: Colors.red,
                      
                      suffixIcon: IconButton(icon:  Icon(exibir ? Icons.visibility :Icons.visibility_off),onPressed: (){
                        setState(() {
                          exibir = !exibir; 
                        });
                      }),
                      hintText: "Digite sua senha"),
                      obscureText: exibir,
                      obscuringCharacter: '*',
                      
                      
                      controller: senha_n,
                     
                    ),
                  ),
                ],
              ),
      
            ),
            ElevatedButton(onPressed: (){
              _cadastrausuario();
            }, child: Text("Cadastrar"),),
            
          ],
        ),
      ),
    );
  }
}


class Users{
  String id;
  String login;
  String senha;
  Users(this.id,this.login, this.senha);
  // Função para mapear nossos dados após a leitura da api e
  // retorna id, login  e senha
  factory Users.fromJson(Map<String,dynamic>json){
    return Users(json["id"],json["login"],json["senha"]);
  }
}