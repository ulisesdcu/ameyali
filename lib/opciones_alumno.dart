import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votaciones/home_alumno.dart';
import 'package:votaciones/lenguas_alumnos.dart';
import 'package:votaciones/residencias_alumno.dart';
import 'package:votaciones/servicio_alumno.dart';
import 'package:votaciones/terminos.dart';
import 'main.dart';
import 'guardado.dart';

class OpcionesScreen2 extends StatefulWidget {
  @override
  _OpcionesScreenState2 createState() => _OpcionesScreenState2();
}

class _OpcionesScreenState2 extends State<OpcionesScreen2> {
  bool isDarkMode = true;



  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? true;
    });
  }

  void toggleTheme() async {
    setState(() {
      isDarkMode = !isDarkMode;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Cerrar sesión
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => AuthOrHomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    bool isUserAuthorized = user != null && user.emailVerified && authorizedEmails.contains(user.email?.toLowerCase());

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
        leading: IconButton(
          icon: SvgPicture.string(
            '''
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
            <path fill-rule="evenodd" d="M16.5 3.75a1.5 1.5 0 0 1 1.5 1.5v13.5a1.5 1.5 0 0 1-1.5 1.5h-6a1.5 1.5 0 0 1-1.5-1.5V15a.75.75 0 0 0-1.5 0v3.75a3 3 0 0 0 3 3h6a3 3 0 0 0 3-3V5.25a3 3 0 0 0-3-3h-6a3 3 0 0 0-3 3V9A.75.75 0 1 0 9 9V5.25a1.5 1.5 0 0 1 1.5-1.5h6ZM5.78 8.47a.75.75 0 0 0-1.06 0l-3 3a.75.75 0 0 0 0 1.06l3 3a.75.75 0 0 0 1.06-1.06l-1.72-1.72H15a.75.75 0 0 0 0-1.5H4.06l1.72-1.72a.75.75 0 0 0 0-1.06Z" clip-rule="evenodd" />
            </svg>
            ''',
            width: 26.0 * 1.1,
            height: 26.0 * 1.1,
            color: Color(0xFFFF2F4F),
          ),
          onPressed: _signOut,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthOrHomeScreen()),
                );
              },
              child: SvgPicture.asset(
                'assets/icon/ameyali.svg',
                height: 34.0 * 1.1,
                width: 34.0 * 1.1,
                color: Color(0xFF006ef9),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.string(
              isDarkMode
                  ? '''
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" />
                    </svg>
                  '''
                  : '''
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 12.75 21a9.753 9.753 0 0 0 9.002-5.998Z" />
                    </svg>
                  ''',
              width: 26.0 * 1.1,
              height: 26.0 * 1.1,
              color: Color(0xFF006ef9),
            ),
            onPressed: toggleTheme,
          ),
        ],
      ),
      

body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 420.0,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Color(0xFF006ef9)),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? Color(0x500070F9) : Color(0x500070F9),
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.string(
                  '''
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                  <path fill-rule="evenodd" d="M18.685 19.097A9.723 9.723 0 0 0 21.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 0 0 3.065 7.097A9.716 9.716 0 0 0 12 21.75a9.716 9.716 0 0 0 6.685-2.653Zm-12.54-1.285A7.486 7.486 0 0 1 12 15a7.486 7.486 0 0 1 5.855 2.812A8.224 8.224 0 0 1 12 20.25a8.224 8.224 0 0 1-5.855-2.438ZM15.75 9a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" clip-rule="evenodd" />
                  </svg>
                  ''',
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF006ef9),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user != null ? user.email ?? 'No Email' : 'No User',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Color(0xFF006ef9) : Color(0xFF006ef9),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    if (isUserAuthorized)
                      SvgPicture.string(
                        '''
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                        <path fill-rule="evenodd" d="M8.603 3.799A4.49 4.49 0 0 1 12 2.25c1.357 0 2.573.6 3.397 1.549a4.49 4.49 0 0 1 3.498 1.307 4.491 4.491 0 0 1 1.307 3.497A4.49 4.49 0 0 1 21.75 12a4.49 4.49 0 0 1-1.549 3.397 4.491 4.491 0 0 1-1.307 3.497 4.491 4.491 0 0 1-3.497 1.307A4.49 4.49 0 0 1 12 21.75a4.49 4.49 0 0 1-3.397-1.549 4.49 4.49 0 0 1-3.498-1.306 4.491 4.491 0 0 1-1.307-3.498A4.49 4.49 0 0 1 2.25 12c0-1.357.6-2.573 1.549-3.397a4.49 4.49 0 0 1 1.307-3.497 4.49 4.49 0 0 1 3.497-1.307Zm7.007 6.387a.75.75 0 1 0-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 0 0-1.06 1.06l2.25 2.25a.75.75 0 0 0 1.14-.094l3.75-5.25Z" clip-rule="evenodd" />
                        </svg>
                        ''',
                        color: Color(0xFF009EF9),
                        width: 18.0,
                        height: 18.0,
                      ),
                  ],
                ),
                SizedBox(height: 20.0),


GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedScreen()),
    );
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        SvgPicture.string(
          '''
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
          </svg>
          ''',
          width: 20.0,
          height: 20.0,
          color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
        ),
        SizedBox(width: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Guardado",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 10.0),
GestureDetector(
  onTap: toggleTheme, 
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        SvgPicture.string(
          isDarkMode
              ? '''
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" />
                </svg>
              '''
              : '''
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 12.75 21a9.753 9.753 0 0 0 9.002-5.998Z" />
                </svg>
              ''',
          width: 20.0,
          height: 20.0,
          color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
        ),
        SizedBox(width: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            isDarkMode ? "Cambiar a Modo Claro" : "Cambiar a Modo Oscuro", 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 10.0),
GestureDetector(
  onTap: () {
    if (user != null && user.email != null) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Se ha enviado un mensaje a tu correo Institucional, Favor de verificar tu bandeja.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        SvgPicture.string(
          '''
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 0 1 3 3m3 0a6 6 0 0 1-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1 1 21.75 8.25Z" />
          </svg>
          ''',
          width: 20.0,
          height: 20.0,
          color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
        ),
        SizedBox(width: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Cambiar contraseña",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 10.0),
GestureDetector(
  onTap: () {
    _signOut(); 
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        SvgPicture.string(
          '''
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 9V5.25A2.25 2.25 0 0 1 10.5 3h6a2.25 2.25 0 0 1 2.25 2.25v13.5A2.25 2.25 0 0 1 16.5 21h-6a2.25 2.25 0 0 1-2.25-2.25V15m-3 0-3-3m0 0 3-3m-3 3H15" />
        </svg>
          ''',
          width: 20.0,
          height: 20.0,
          color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
        ),
        SizedBox(width: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Cerrar sesión",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 10.0),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TerminosScreen()),
    );
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        SvgPicture.string(
          '''
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
        </svg>

          ''',
          width: 20.0,
          height: 20.0,
          color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
        ),
        SizedBox(width: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Términos y Condiciones",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 15.0),

              ],
            ),
          ),
        ],
      ),
    ),
  ),
),




      bottomNavigationBar: BottomAppBar(
        color: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
</svg>


                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen2()),
                  );
                },
              ),
            ),

            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="m6.115 5.19.319 1.913A6 6 0 0 0 8.11 10.36L9.75 12l-.387.775c-.217.433-.132.956.21 1.298l1.348 1.348c.21.21.329.497.329.795v1.089c0 .426.24.815.622 1.006l.153.076c.433.217.956.132 1.298-.21l.723-.723a8.7 8.7 0 0 0 2.288-4.042 1.087 1.087 0 0 0-.358-1.099l-1.33-1.108c-.251-.21-.582-.299-.905-.245l-1.17.195a1.125 1.125 0 0 1-.98-.314l-.295-.295a1.125 1.125 0 0 1 0-1.591l.13-.132a1.125 1.125 0 0 1 1.3-.21l.603.302a.809.809 0 0 0 1.086-1.086L14.25 7.5l1.256-.837a4.5 4.5 0 0 0 1.528-1.732l.146-.292M6.115 5.19A9 9 0 1 0 17.18 4.64M6.115 5.19A8.965 8.965 0 0 1 12 3c1.929 0 3.716.607 5.18 1.64" />
            </svg>
                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LenguasScreen2()),
                  );
                },
              ),
            ),

            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z" />
            </svg>
                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ServicioScreen2()),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 14.15v4.25c0 1.094-.787 2.036-1.872 2.18-2.087.277-4.216.42-6.378.42s-4.291-.143-6.378-.42c-1.085-.144-1.872-1.086-1.872-2.18v-4.25m16.5 0a2.18 2.18 0 0 0 .75-1.661V8.706c0-1.081-.768-2.015-1.837-2.175a48.114 48.114 0 0 0-3.413-.387m4.5 8.006c-.194.165-.42.295-.673.38A23.978 23.978 0 0 1 12 15.75c-2.648 0-5.195-.429-7.577-1.22a2.016 2.016 0 0 1-.673-.38m0 0A2.18 2.18 0 0 1 3 12.489V8.706c0-1.081.768-2.015 1.837-2.175a48.111 48.111 0 0 1 3.413-.387m7.5 0V5.25A2.25 2.25 0 0 0 13.5 3h-3a2.25 2.25 0 0 0-2.25 2.25v.894m7.5 0a48.667 48.667 0 0 0-7.5 0M12 12.75h.008v.008H12v-.008Z" />
              </svg>
                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ResidenciasScreen2()),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
              <path fill-rule="evenodd" d="M11.078 2.25c-.917 0-1.699.663-1.85 1.567L9.05 4.889c-.02.12-.115.26-.297.348a7.493 7.493 0 0 0-.986.57c-.166.115-.334.126-.45.083L6.3 5.508a1.875 1.875 0 0 0-2.282.819l-.922 1.597a1.875 1.875 0 0 0 .432 2.385l.84.692c.095.078.17.229.154.43a7.598 7.598 0 0 0 0 1.139c.015.2-.059.352-.153.43l-.841.692a1.875 1.875 0 0 0-.432 2.385l.922 1.597a1.875 1.875 0 0 0 2.282.818l1.019-.382c.115-.043.283-.031.45.082.312.214.641.405.985.57.182.088.277.228.297.35l.178 1.071c.151.904.933 1.567 1.85 1.567h1.844c.916 0 1.699-.663 1.85-1.567l.178-1.072c.02-.12.114-.26.297-.349.344-.165.673-.356.985-.57.167-.114.335-.125.45-.082l1.02.382a1.875 1.875 0 0 0 2.28-.819l.923-1.597a1.875 1.875 0 0 0-.432-2.385l-.84-.692c-.095-.078-.17-.229-.154-.43a7.614 7.614 0 0 0 0-1.139c-.016-.2.059-.352.153-.43l.84-.692c.708-.582.891-1.59.433-2.385l-.922-1.597a1.875 1.875 0 0 0-2.282-.818l-1.02.382c-.114.043-.282.031-.449-.083a7.49 7.49 0 0 0-.985-.57c-.183-.087-.277-.227-.297-.348l-.179-1.072a1.875 1.875 0 0 0-1.85-1.567h-1.843ZM12 15.75a3.75 3.75 0 1 0 0-7.5 3.75 3.75 0 0 0 0 7.5Z" clip-rule="evenodd" />
              </svg>

                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OpcionesScreen2()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
