import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  FirebaseUser user;
  String name="";
  String email="";
  String success="";
  String newPw="";
  final AuthService _auth = AuthService();
  void initState() {
    super.initState();
    initUser();

  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  void _changePassword(String password) async{
    user.updatePassword(password).then((_){
      print("Succesfully changed password");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(""),
              content: Text("Mot de passe changé avec succès!"),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }).catchError((error){
      print("Password can't be changed" + error.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    try {
      name = user.displayName;
      email = user.email;
    }

    catch (e){

    }

    @override
    initState() {
      super.initState();
    }

    return Scaffold(
        appBar: AppBar(
            title: Text('My To Do app'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Colors.indigo[300],
                        Colors.tealAccent[100]
                      ])
              ),
            )),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.indigo[400].withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 400.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/avatar.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.indigoAccent)
                            ])),
                    SizedBox(height: 90.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon (Icons.account_circle),
                        SizedBox(
                          width:5,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.indigo,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico'),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon (Icons.email),
                        SizedBox(
                          width:5,
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Text('Changer mon mot de passe'),
                      color: Colors.indigoAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Changement de mot de passe'),
                                content: TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    newPw = value;
                                  },
                                  controller: _textFieldController,
                                  decoration: InputDecoration(hintText: "Entrez votre nouveau mot de passe"),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text('Annuler'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text('Enregistrer'),
                                    onPressed: () {
                                      try
                                      {_changePassword(newPw);
                                      Navigator.of(context).pop();
                                       }
                                          catch (e) {}
                                    },
                                  )
                                ],
                              );
                            });

                      },)



                  ],
                ))
          ],
        ));
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      _textFieldController.dispose();
      super.dispose();
    }
  }

}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 180, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    
    return true;
  }




}


