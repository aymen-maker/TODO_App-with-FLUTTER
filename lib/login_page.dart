import 'auth.dart';
import 'loading.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'Widgets/SocialIcons.dart';
import 'package:email_validator/email_validator.dart';
import 'CustomIcons.dart';
import 'inscription.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage="";
  final _formKey = GlobalKey<FormState>();
  String email="";
  String password="";
    final AuthService _auth = AuthService();
    final GoogleAuth _authG = GoogleAuth();
    bool _isSelected = false;
    bool loading = false;

    void _radio() {
      setState(() {
        _isSelected = !_isSelected;
      });
    }

    Widget formCard() => Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(570),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Se connecter",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Adresse e-mail",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
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
                decoration: InputDecoration(
                    hintText: "votre adresse e-mail",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Mot de passe",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "votre mot de passe",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      loading = true;
  try {
    dynamic result = await _auth.signInAnon();
  if (result == null) {
  setState(() {
  loading = false;
  errorMessage = "Veuillez vérifier vos informations ou inscrivez-vous";
  });
  }
  }
  catch (error) {
  print(error.toString());}

                    },
                    child: Text(
                      "Connexion anonyme?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(28)),
                    ),
                  ),
                ],
              ),
              Center(child: Text(errorMessage,
                  style: TextStyle(
                  color: Colors.red,
                  fontFamily: "Poppins-Medium",
                  fontSize: 12))),
            ],
          ),
        ),
      ),
    );

    Widget radioButton(bool isSelected) =>
        Container(
          width: 16.0,
          height: 16.0,
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2.0, color: Colors.black)),
          child: isSelected
              ? Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          )
              : Container(),
        );

    Widget horizontalLine() =>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: ScreenUtil.getInstance().setWidth(120),
            height: 1.0,
            color: Colors.black26.withOpacity(.2),
          ),
        );

    Widget FormCard() =>
        Container(
          width: double.infinity,
          height: ScreenUtil.getInstance().setHeight(500),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -10.0),
                    blurRadius: 10.0),
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Se connecter",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(45),
                          fontFamily: "Poppins-Bold",
                          letterSpacing: .6)),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Text("Adresse e-mail",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "votre adresse e-mail",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 12.0)),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Text("Mot de passe",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "votre mot de passe",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 12.0)),

                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Mot de passe oublié?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(28)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );

    Widget backPic() =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 50, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                "assets/image_01.jpg",
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
          ],
        );



    Widget seRappeler() =>
        Row(
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            GestureDetector(
              onTap: _radio,
              child: radioButton(_isSelected),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text("Se rappeler de moi",
                style: TextStyle(
                    fontSize: 12, fontFamily: "Poppins-Medium"))
          ],
        );

    Widget connexionButton() =>
        Container(
          width: ScreenUtil.getInstance().setWidth(300),
          height: ScreenUtil.getInstance().setHeight(100),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF17ead9),
                Color(0xFF6078ea)
              ]),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  try {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        errorMessage = "Veuillez vérifier vos informations ou inscrivez-vous";
                      });
                    }
                  }
                  catch (error) {
                    print(error.toString());
                    /*switch (error.code) {
                      case "ERROR_INVALID_EMAIL":
                        errorMessage =
                        "Your email address appears to be malformed.";
                        break;
                      case "ERROR_WRONG_PASSWORD":
                        errorMessage = "Your password is wrong.";
                        break;
                      case "ERROR_USER_NOT_FOUND":
                        errorMessage = "User with this email doesn't exist.";
                        break;
                      case "ERROR_USER_DISABLED":
                        errorMessage =
                        "User with this email has been disabled.";
                        break;
                      case "ERROR_TOO_MANY_REQUESTS":
                        errorMessage = "Too many requests. Try again later.";
                        break;
                      case "ERROR_OPERATION_NOT_ALLOWED":
                        errorMessage =
                        "Signing in with Email and Password is not enabled.";
                        break;
                      default:
                        errorMessage = "An undefined Error happened.";
                    }*/
                  }
                }
              },
              child: Center(
                child: Text("Connexion",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Bold",
                        fontSize: 18,
                        letterSpacing: 1.0)),
              ),
            ),
          ),
        );

    Widget socialIcons() =>
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*SocialIcon(
              colors: [
                Color(0xFF102397),
                Color(0xFF187adf),
                Color(0xFF00eaf8),
              ],
              iconData: CustomIcons.facebook,
              onPressed: () {},
            ),*/
            SocialIcon(
              colors: [
                Color(0xFFff4f38),
                Color(0xFFff355d),
              ],
              iconData: CustomIcons.googlePlus,
              onPressed: () async {/*signInWithGoogle().whenComplete(() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MainPage();
                    },
                  ),
                );
              });
              */
                dynamic result = await _authG.signInWithGoogle();

              },
            ),/*
            SocialIcon(
              colors: [
                Color(0xFF17ead9),
                Color(0xFF6078ea),
              ],
              iconData: CustomIcons.twitter,
              onPressed: () {},
            ),
            SocialIcon(
              colors: [
                Color(0xFF00c6fb),
                Color(0xFF005bea),
              ],
              iconData: CustomIcons.linkedin,
              onPressed: () {},
            )*/
          ],
        );

    Widget nouvelUtilisateur() =>
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Nouvel utilisateur? ",
              style: TextStyle(fontFamily: "Poppins-Medium"),
            ),
            FlatButton(
              onPressed: () {
                print("hello");
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return new InscrFormPage();
                    },
                  ));

                },
                child: Text("s'inscrire",
                    style: TextStyle(
                        color: Color(0xFF5d74e3),
                        fontFamily: "Poppins-Bold")),
              ),
            )
          ],
        );

    //final _formKey = GlobalKey<FormState>();
    @override
    Widget build(BuildContext context) {
      ScreenUtil.instance = ScreenUtil.getInstance()
        ..init(context);
      ScreenUtil.instance =
          ScreenUtil(width: 750, height: 1400, allowFontScaling: true);

      return loading ? Loading(): Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('My To-Do App'),
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
            )
        ),
        body: SafeArea(
          child:Center(
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: <Widget>[
              backPic(),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 80.0),
                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(150),
                      ),
                      formCard(),
                      //contains form card
                      SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          seRappeler(),
                          InkWell(
                            child: connexionButton(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          horizontalLine(),
                          Text("Login social",
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: "Poppins-Medium")),
                          horizontalLine()
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(10),
                      ),
                      socialIcons(),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(15),
                      ),
                      nouvelUtilisateur(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
      );
    }
  }



