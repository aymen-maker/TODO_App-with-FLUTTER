import "package:flutter/material.dart";
import 'Task.dart';
import 'package:intl/intl.dart';
import 'FirstScreen.dart';
class TaskFormPage extends StatefulWidget {
  @override
  _TaskFormPageState createState() => new _TaskFormPageState();

}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  String n="";
  String c="";
  /*final myController = TextEditingController();
  void dispose() {
    myController.dispose();
    super.dispose();
  }*/
  var _items = new ItemsRepository().getItems();
  var _itemsTot = new ItemsRepositoryTot().getItems();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                  "assets/yoga.jpg",
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              Text("Ajoutez une tâche",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                      color: Colors.white
                  )
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextFormField(
                        onSaved: (String value) {

                          n=value;
                        },
                        //controller: myController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer une tâche';
                          }
                          return null;
                        },
                        //autofocus: true,
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            labelText: 'Donnez un nom à votre tâche...',
                            contentPadding: const EdgeInsets.all(20.0)),

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        //controller: myController,
                        onSaved: (String value) {
                          var now = new DateTime.now();
                          var formatter = new DateFormat('yyyy-MM-dd');
                          String date = formatter.format(now);
                          int l = _items.length;
                          Item task = new Item(l, n, date, value,false);

                            _items.add(task);
                            _itemsTot.add(task);


                        },
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            labelText: 'Décrivez-la',
                            contentPadding: const EdgeInsets.fromLTRB(20, 50, 20, 50)),
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
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              Navigator.pop(context, () {
                                setState(() {});
                              });

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


