import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'home_alumno.dart';
import 'package:flutter/gestures.dart';
import 'terminos.dart'; 

// Lista de correos autorizados para publicar
const List<String> authorizedEmails = [
  'vinculacion@tecvalles.mx',
  'gtyv@tecvalles.mx',
  'lenguas.extranjeras@tecvalles.mx',
  'servicio.social@tecvalles.mx',
  'practicasypromocion@tecvalles.mx',
  '20690035@tecvalles.mx',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: const Color(0xFF006EF9),
          selectionColor: const Color(0xFF006EF9),
          selectionHandleColor: const Color(0xFF006EF9),
        ),
      ),
      home: AuthOrHomeScreen(),
    );
  }
}

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          User user = snapshot.data!;
          if (authorizedEmails.contains(user.email)) {
            return HomeScreen(); 
          } else {
            return HomeScreen2(); 
          }
        } else {
          return AuthScreen();
        }
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLogin = true;
  Color _backgroundColor = Color(0xFF000D19);

  // Variables para controlar la visibilidad de las contraseñas
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Variables para el parpadeo
  bool _isBlinking = false;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    _startBlinking();
  }

  void _startBlinking() {
    _blinkTimer = Timer.periodic(Duration(milliseconds: 4500), (timer) {
      setState(() {
        _isBlinking = !_isBlinking;
      });
      
;
    });
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }

  void _resetPassword() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, ingresa un correo institucional válido.'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Correo de recuperación enviado a $email.'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al enviar el correo de recuperación.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, completa todos los campos.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (!email.endsWith('@tecvalles.mx')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Solo se admiten correos institucionales.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authorizedEmails.contains(userCredential.user?.email)) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen2()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('La cuenta no existe o fue suspendida.'),
        backgroundColor: Colors.red,
      ));
    }
  }

void _register() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  String confirmPassword = _confirmPasswordController.text.trim();

  // Verificar si hay campos vacíos
  if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Por favor, completa todos los campos.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  // Validación del correo institucional
  if (!email.endsWith('@tecvalles.mx')) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Solo se admiten correos institucionales.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  // Verificar si las contraseñas coinciden
  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Las contraseñas no coinciden.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  // Validación de la longitud de la contraseña
  if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Las contraseñas deben tener al menos 6 caracteres.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  try {
    // Crear el usuario con email y contraseña
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Verificar el email autorizado
    if (authorizedEmails.contains(userCredential.user?.email)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen2()),
      );
    }
  } on FirebaseAuthException catch (e) {
    // Si ocurre un error en el registro, mostrar el mensaje de error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? 'Error desconocido al registrar.'),
      backgroundColor: Colors.red,
    ));
  }
}


  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
      _backgroundColor = _isLogin ? Color(0xFF000D19) : Color(0xFFE7EFFF);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icon/tec.svg',
                      width: 200.0,
                      fit: BoxFit.contain,
                      color: Color(0xFFF006EF9),
                    ),
                    SizedBox(height: 7.0),
                    SvgPicture.asset(
                      'assets/icon/ameyalitext.svg',
                      width: 500.0,
                      fit: BoxFit.contain,
                      color: Color(0xFF006EF9),
                    ),
                    SizedBox(height: 30.0),
                    _buildTextField(_emailController, 'Ingresar correo', false, TextInputType.emailAddress, [AutofillHints.email]),
                    SizedBox(height: 20.0),
                    _buildTextField(_passwordController, 'Ingresar contraseña', true, TextInputType.text, [AutofillHints.password]),
                    if (!_isLogin)
                      Column(
                        children: [
                          SizedBox(height: 20.0),
                          _buildTextField(_confirmPasswordController, 'Confirmar contraseña', true, TextInputType.text, [AutofillHints.newPassword]),
                        ],
                      ),
                    SizedBox(height: 20.0),
                    _buildButton(
                      onPressed: _isLogin ? _login : _register,
                      text: _isLogin ? 'Entrar' : 'Registrarse',
                      textColor: _isLogin ? const Color(0xFF000D1D) : const Color(0xFFE7EFFF),
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      onPressed: _toggleForm,
                      child: AnimatedOpacity(
                        opacity: _isBlinking ? 1.0 : 1.0,
                        duration: Duration(milliseconds: 0),
                        child: Text(
                          _isLogin ? '¿No tienes cuenta? Regístrate' : '¿Ya tienes cuenta? Inicia sesión',
                          style: TextStyle(
                            color: const Color(0xFF006EF9),
                            fontSize: 16,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (_isLogin)
                      TextButton(
                        onPressed: _resetPassword,
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: const Color(0xFFFF2F4F), fontWeight: FontWeight.bold,),
                        ),
                      ),
                    SizedBox(height: 20.0), 
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Al Registrarse y/o Iniciar sesión, aceptas que has leído los  ',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF006EF9),
                ),
              ),
              TextSpan(
                text: 'Términos y condiciones.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF006EF9),
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TerminosScreen()),
                    );
                  },
              ),
              TextSpan(
                text: '\n©2025. Tecnológico Nacional de México Instituto de Ciudad Valles',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF006EF9),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, bool obscureText, TextInputType keyboardType, List<String> autofillHints) {
    return Container(
      width: 500.0, 
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: const Color(0xFF006EF9),
        obscureText: obscureText && !(controller == _passwordController && _isPasswordVisible) && !(controller == _confirmPasswordController && _isConfirmPasswordVisible),
        autofillHints: autofillHints,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF69BBFF),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: const Color(0xFF006EF9),
            ),
          ),
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    (controller == _passwordController && _isPasswordVisible) ||
                    (controller == _confirmPasswordController && _isConfirmPasswordVisible)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF006EF9),
                  ),
                  onPressed: () {
                    setState(() {
                      if (controller == _passwordController) {
                        _isPasswordVisible = !_isPasswordVisible;
                      } else if (controller == _confirmPasswordController) {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      }
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required String text, required Color textColor}) {
    return Container(
      width: 500.0, 
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF000D19),
          backgroundColor: const Color(0xFF006EF9),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
