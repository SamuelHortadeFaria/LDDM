import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'home.dart';
import 'globo.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'package:application_lddm/entitis/userProviders.dart';
import 'package:application_lddm/entitis/database_helper.dart';

class UserProfileScreen extends StatelessWidget {

  Future<void> _logout(BuildContext context) async {
    await DatabaseHelper().deleteUser();
    Provider.of<UserProvider>(context, listen: false).clearUsuario();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtendo as informações do usuário do UserProvider
    final usuario = Provider.of<UserProvider>(context).usuario;

    // Verificando se o usuário está presente
    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(title: Text("World Chat")),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nenhum usuário encontrado."),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/cadastro'),
                    child: Text("Faça o seu Cadastro!")),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text("Entre se já possui uma conta.")),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'País',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: 2, // Mantém a aba de Perfil selecionada
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                PageTransition(child: CountryLanguageScreen(), type: PageTransitionType.leftToRight),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                PageTransition(child: MyHomePage(), type: PageTransitionType.leftToRight),
              );
            }
            // A tela de perfil já está ativa, então não fazemos nada aqui
          },
        ),
      );
    }

    // Caso o usuário esteja presente, exibe o perfil
    return Scaffold(

      //AppBar
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.blueAccent,
      ),

      //Body + Padding
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(usuario.getImagem()),
              ),
              SizedBox(height: 16),
              Text(
                'Nome: ${usuario.getNome()}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Idade: ${usuario.getIdade()}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: usuario.getLingua(),
                onChanged: (String? newValue) {
                  // Lógica para alterar a língua nativa
                },
                items: [usuario.getLingua()].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Local onde mora: ${usuario.getLocal()}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Ação para o histórico de línguas
                },
                icon: Icon(Icons.history),
                label: Text('Histórico de Línguas'),
              ),
              SizedBox(height: 16),
              
              ElevatedButton(
                onPressed: () {
                  _logout(context);  // Chama a função _logout para realizar o logout
                },
                child: Text("Sair"),
              ),
            ],
          ),

        )

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'País',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 2, // Mantém a aba de Perfil selecionada
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              PageTransition(child: CountryLanguageScreen(), type: PageTransitionType.leftToRight),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              PageTransition(child: MyHomePage(), type: PageTransitionType.leftToRight),
            );
          }
          // A tela de perfil já está ativa, então não fazemos nada aqui
        },
      ),
    );
  }
}