import 'loading.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'auth.dart';
class InscrFormPage extends StatefulWidget {
  @override
  _InscrFormPageState createState() => new _InscrFormPageState();

}

class _InscrFormPageState extends State<InscrFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final AuthService _auth = AuthService();
  String email="";
  String password="";
  String pseudo = "";
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        body:
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.indigo[200],Colors.lightBlueAccent[100]])),
            child: Column(
              children: <Widget>[
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 100, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    "assets/productivity.jpg",
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Entrez vos informations",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                          color: Colors.white
                      )
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(

                          validator: (value) {
                            if (value.isEmpty) {
                              return "Vous devez avoir un nom d'utilisateur";
                            }
                            return null;
                          },

                          onChanged: (val){
                            setState(() {
                              pseudo=val;
                            });
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              labelText: "Votre nom d'utilisateur",
                              contentPadding: const EdgeInsets.all(20.0)),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          onChanged: (val){
                            setState(() {
                              email=val;
                            });
                          },

                          validator: (value) {
                            if (!EmailValidator.validate(value)) {
                              return 'Veuillez entrer une adresse e-mail valide';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              labelText: 'Votre adresse e-mail',
                              contentPadding: const EdgeInsets.all(20.0)),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          onChanged: (val){
                            setState(() {
                              password=val;
                            });
                          },
                          obscureText: true,
                          //controller: myController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              labelText: 'Un mot de passe',
                              contentPadding: const EdgeInsets.all(20.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close),
                              backgroundColor: Colors.deepPurple[400],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth.registerWithEmailAndPassword(email, password, pseudo);
                                  //_formKey.currentState.save();
                                  Navigator.pop(context);
                                  if (result==null) {
                                    setState(() {
                                      loading=false;
                                    });
                                  }
                                }

                              },
                              child: Icon(Icons.check),
                              backgroundColor: Colors.deepPurple[400],
                            ),


                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            )
        )

    );
  }


}


