import 'package:flutter/material.dart';
import 'TaskList.dart';
import 'auth.dart';
import 'profil.dart';
import 'sign_in.dart';
import 'login_page.dart';
class NavDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _toHist() {
      Navigator.of(context).push(new MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return new HistPage();
        },
      ));
    }

    void _toProfil() {
      Navigator.of(context).push(new MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return new Profil();
        }
      ));
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Mon espace',
              style: TextStyle(color: Colors.pink[400], fontSize: 45,fontFamily: "Pacifico"),
            ),
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                image: DecorationImage(

                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_01.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profil'),
            onTap: () {
              _toProfil();
            }
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique'),
            onTap: () {
              _toHist();
            }
          ),
          /*ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () => {Navigator.of(context).pop()},
          ),*/

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Déconnexion'),
            onTap: () async {
              await _auth.signOut();
              //await signOutGoogle();
              //Route route = MaterialPageRoute(builder: (context) => LoginPage());
              //Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
    );
  }
}