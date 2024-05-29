
import 'package:flutter/material.dart'; 
import 'package:somativa_app/cadastrocliente.dart';
import 'package:somativa_app/filmes.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool exibir = false; 
  _verificaLogin()async{
   bool encuser = false; 
    String url = "http://10.109.83.04:3000/usuarios"; 
    http.Response resposta = await http.get(Uri.parse(url)); 
    print(resposta.statusCode);
    List dados = [];
    dados = json.decode(resposta.body) as List;     
    for(int i=0; i<dados.length;){
       if(user.text == dados[i]["nome"] && senha.text == dados[i]["senha"]){
        encuser = true;
        break;
       } else {
        i++;
       }
    }
       if(encuser ==true){
        print("Usuario ${user.text} encontrado");
        encuser = false;
        
        user.text ="";
        senha.text ="";

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Filmes()));
       }
       else{
        print("Usuario ${user.text} nao encontrado");
       }
    }
    
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Login"),
      ),
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
                      icon: Icon(Icons.people_alt_outlined,color: Colors.green,),
                      hintText: "Digite seu nome"),
                      
                      controller: user,
                     
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      icon: Icon(Icons.key_outlined,),iconColor: Colors.green,
                     
                      suffixIcon: IconButton(icon:  Icon(exibir ? Icons.visibility_off :Icons.visibility),onPressed: (){
                        setState(() {
                          exibir = !exibir; 
                        });
                      }),
                      hintText: "Digite sua senha"),
                      obscureText: exibir,
                      obscuringCharacter: '*',
                      
                      controller: senha,
                     
                    ),
                  ),
                ],
              ),
      
            ),
            ElevatedButton(onPressed: _verificaLogin, child: Text("Entrar"),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cadastrousuario()));
              
            }, child: Text("Cadastrar")),
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
  
  factory Users.fromJson(Map<String,dynamic>json){
    return Users(json["id"],json["nome"],json["senha"]);
  }
}