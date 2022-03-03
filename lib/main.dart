<<<<<<< HEAD
// @dart=2.9
=======
import 'package:cuideam/menu.dart';
>>>>>>> ca00bf8 (v0.0.5)
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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


    // Generate cryptography machines
    // --------
    // generated AES encrypter with key + padding
    var aes = AesCrypt(key: key32, padding: PaddingAES.pkcs7);
    print("key: "+key32);
    //AES CTR; Symmetric stream cipher
    //print('AES Symmetric CTR:');
    var crypted2 = aes.ctr.encrypt(inp: txt, iv: iv16); //Encrypt.
    //print(crypted2);
    //print(aes.ctr.decrypt(enc: crypted2, iv: iv16)); //Decrypt.
    //print('');
    setState(() {
      llave = key32;
      llabe16 = iv16;
      encriptado = crypted2;
      //print('Pruba:');
      //print(encriptado);
      //print(aes.ctr.decrypt(enc: encriptado, iv: iv16));
    });
  }

  mensaje(String txt1, String txt2){
    //AnimationController _controller = AnimationController(
     // vsync: this,
      //duration: Duration(seconds: time),
    //);
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      //mainButton: FlatButton(
        //onPressed: (){},
        //child: const Text(
          //"OK",
          //style: TextStyle(color: Colors.amber),
        //),
      //),
      //showProgressIndicator:true,
      //progressIndicatorController: _controller,
      //progressIndicatorBackgroundColor: Colors.indigo,
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
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png',width: 300,)
              ],
            ),
           const SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.all(30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0,5)
                )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text('Bienvenido', style: TextStyle(
                      fontWeight:  FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromRGBO(33, 33, 33, 1)
                    ),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text('Empecemos', style: TextStyle(
                      fontSize: 20
                    ),),
                  ),
                  const SizedBox(height: 30,),
                   Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Form(
                    key: _formKey,
                      child: Column(
                        children: <Widget> [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _textMail,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Faltan datos';
                              }else{
                                bool _correctEmail = EmailValidator.validate(value);
                                if(! _correctEmail){
                                  return 'correo invalido';
                                }
                              }
                            },
                            autofocus: false,
                            decoration: const InputDecoration(
                              hintText: 'Correo',
                              prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18
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
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _textPass,
                              validator: (value){
                              if(value.isEmpty){
                                return 'Faltan datos';
                              }else{

                              }
                              },
                              autofocus: false,
                              decoration: const InputDecoration(
                                hintText: 'Contraseña',
                                prefixIcon: Icon(Icons.security),
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18
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
                      if(_formKey.currentState.validate()){
                        //mensaje('Cuenta creada','Bienvenido a Cuideam');
                        main(_textPass.text);
                        _GetData(_textMail.text, encriptado);
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(padding: EdgeInsets.all(20),
                          child: Text(' Crear cuenta', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),),
                          )
                        ],
                      ),
                      decoration:  BoxDecoration(
                        color: const Color.fromRGBO(0, 151, 167, 150),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(_formKey.currentState.validate()){
                        //mensaje('Inicio de sesión exitosa','Bienvenido a Cuideam');
                        //main(_textPass.text);
                        _Sesion(_textMail.text, _textPass.text);
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(padding: EdgeInsets.all(20),
                            child: Text('Inicia Sesión Ahora', style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),),
                          )
                        ],
                      ),
                      decoration: const BoxDecoration(
                          color:  Color.fromRGBO(139, 195, 74, 100),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
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
