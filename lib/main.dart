import 'package:cuideam/menu.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin  {
  final _formKey = GlobalKey<FormState>();
  final _textMail = TextEditingController();
  final _textPass = TextEditingController();
  int time = 4;
  String encriptado = "";
  String llave = "";
  String llabe16 = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _Start();
  }

  void main(String txt) {
    var keyGen = CryptKey();

    var key32 = keyGen.genFortuna(len: 32);

    var iv16 = keyGen.genDart(len: 16);

    var aes = AesCrypt(key: key32, padding: PaddingAES.pkcs7);
    print("key: "+key32);
    var crypted2 = aes.ctr.encrypt(inp: txt, iv: iv16);
    setState(() {
      llave = key32;
      llabe16 = iv16;
      encriptado = crypted2;
    });
  }

  mensaje(String txt1, String txt2){
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      title:  txt1,
      message:  txt2,
      duration:   Duration(seconds: time),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover
        )
      ),

      child:  Scaffold(
          backgroundColor: Colors.transparent,
        body:  ListView(
          children: [
            Padding(padding: const EdgeInsets.all(25),
            child: Card(
              elevation: 15,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 25),


              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png',width: 265,)
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 1, right: 15, bottom: 15),
                    child: const Text('Bienvenido', style: TextStyle(
                        fontWeight:  FontWeight.w700,
                        fontSize: 30,
                        color: Color.fromRGBO(33, 33, 33, 1)
                    ),),
                  ),

                  Container(
                    padding: const EdgeInsets.all(1),
                    child: const Text('Es momento de relajarse...', style: TextStyle(
                      fontSize: 20,
                      fontWeight:  FontWeight.w300,
                    ),),
                  ),

                  const SizedBox(height: 40,),
                   Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),

                  child: Form(
                    key: _formKey,
                      child: Column(
                        children: <Widget> [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _textMail,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Faltan datos';
                              }else{
                                bool _correctEmail = EmailValidator.validate(value);
                                if(! _correctEmail){
                                  return 'Correo invalido';
                                }
                              }
                            },
                            autofocus: false,
                            decoration: const InputDecoration(
                              hintText: 'Correo',
                              contentPadding: EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 5),
                              prefixIcon: Icon(Icons.mail),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),

                          TextFormField(
                            cursorColor: Colors.lightGreen,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _textPass,
                              validator: (value){
                              if(value!.isEmpty){
                                return 'Escribe tus datos, por favor';
                              }else{

                              }
                              },
                              autofocus: false,
                              decoration: const InputDecoration(
                                hintText: 'Contraseña',
                                prefixIcon: Icon(Icons.security),
                                contentPadding: EdgeInsets.only(left: 25, top: 15, right: 25, bottom: 5),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2
                                    )
                                ),
                              ),
                            ),
                        ],
                      ),
                  ),
                  ),

                 const SizedBox(height: 60,),
                  InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        main(_textPass.text);
                        _GetData(_textMail.text, encriptado);
                      }
                    },

                    child: Container(
                      margin: const EdgeInsets.only(top: 0, left: 55, right: 55, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(15),
                          child: Text('Crea una cuenta', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                          ),
                          ),
                          )
                        ],
                      ),

                      decoration:  BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        _Sesion(_textMail.text, _textPass.text);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, left: 55, right: 55, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(padding: EdgeInsets.all(15),
                            child: Text('Inicia sesión', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black
                            ),),
                          )
                        ],
                      ),
                      decoration:  BoxDecoration(
                        color: Colors.lightGreen.shade300,
                        borderRadius: BorderRadius.circular(25),
                      ),

                    ),
                  ),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );

  }

  Future<void> _Start() async {
    final sharedprefs = await SharedPreferences.getInstance();
    String mails = sharedprefs.getString('mail') ?? "0";
    String pas = sharedprefs.getString('pass') ?? "0";
    String key = sharedprefs.getString('key') ?? "0";
    String key16 = sharedprefs.getString('keys') ?? "0";

    String login = sharedprefs.getString('log') ?? "0";

    setState(() {
      if(  "0" == mails ){
        print("te faltan datos");
      }else{
        print('ya hay una cuenta');
        if(login == "1"){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Menu()),
          );
        }
      }
    });
  }
  Future<void> _GetData(String mail, String pass) async {
    final sharedprefs = await SharedPreferences.getInstance();
    String mails = sharedprefs.getString('mail') ?? "0";
    String pas = sharedprefs.getString('pass') ?? "0";
    String key = sharedprefs.getString('key') ?? "0";
    String key16 = sharedprefs.getString('keys') ?? "0";
    setState(() {
      if(  "0" == mails ){
        print("te faltan datos");
        _putData(mail,pass);
      }
    });
  }
  Future<void> _putData(String mail, String pass) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setString("mail", mail);
    await sharedprefs.setString("pass", pass);
    await sharedprefs.setString("key", llave);
    await sharedprefs.setString("keys", llabe16);
    await sharedprefs.setString('log', "1") ;
    _GetData(mail, pass);
    //setState(() {Navigator.of(context).push(MaterialPageRoute(builder: (context) => introduction()),);});
  }
  Future<void> _Sesion(String mail, String pass) async {
    final sharedprefs = await SharedPreferences.getInstance();
    String mails = sharedprefs.getString('mail') ?? "0";
    String pas = sharedprefs.getString('pass') ?? "0";
    String key = sharedprefs.getString('key') ?? "0";
    String key16 = sharedprefs.getString('keys') ?? "0";
    setState(() {
      if(mails=="0"){

          mensaje('Error','Cuenta no existente');
      }else{
        var aes = AesCrypt(key: key, padding: PaddingAES.pkcs7);
        String result = aes.ctr.decrypt(enc: pas, iv: key16);
        print("Correo: "+mails+" "+"Password: "+pas);
        if(mail == mails && pass == result){
          mensaje('Inicio de sesión exitosa','Bienvenido a Cuideam');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Menu()),
          );
          print('vamos al menu');
        }else{
          mensaje('Error','Cuenta no existente');
        }
      }
    });
  }
}
