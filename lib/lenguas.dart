import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'crear_posts.dart';
import 'servicio.dart';
import 'residencias.dart';
import 'main.dart';
import 'home.dart';
import 'opciones.dart';

class LenguasScreen extends StatefulWidget {
  @override
  _LenguasScreenState createState() => _LenguasScreenState();
}
class _LenguasScreenState extends State<LenguasScreen> {
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => AuthOrHomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts_lenguas').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: SvgPicture.asset(
                isDarkMode 
                    ? 'assets/icon/loro_solid.svg' 
                    : 'assets/icon/loro_line.svg',
                height: 200.0, 
                color: Color(0xFF006EF9), 
              ),
            );
          }

          final posts = snapshot.data!.docs;

          return ListView(
            children: posts.map((doc) {
              return PostTile(doc: doc, isDarkMode: isDarkMode, context: context); 
            }).toList(),
          );
        },
      ),

floatingActionButton: Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.only(left: 34.0), 
    child: FloatingActionButton.extended(
      heroTag: "createPost",
      backgroundColor: Color(0xFF006ef9),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CreatePostScreen()),
        );
      },
      label: Row(
        mainAxisSize: MainAxisSize.min, 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          SvgPicture.string(
            '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
              <path d="M21.731 2.269a2.625 2.625 0 0 0-3.712 0l-1.157 1.157 3.712 3.712 1.157-1.157a2.625 2.625 0 0 0 0-3.712ZM19.513 8.199l-3.712-3.712-8.4 8.4a5.25 5.25 0 0 0-1.32 2.214l-.8 2.685a.75.75 0 0 0 .933.933l2.685-.8a5.25 5.25 0 0 0 2.214-1.32l8.4-8.4Z" />
              <path d="M5.25 5.25a3 3 0 0 0-3 3v10.5a3 3 0 0 0 3 3h10.5a3 3 0 0 0 3-3V13.5a.75.75 0 0 0-1.5 0v5.25a1.5 1.5 0 0 1-1.5 1.5H5.25a1.5 1.5 0 0 1-1.5-1.5V8.25a1.5 1.5 0 0 1 1.5-1.5h5.25a.75.75 0 0 0 0-1.5H5.25Z" />
            </svg>''',
            height: 24.0,
            width: 24.0,  
            color: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
          ),
          SizedBox(width: 8),
          Text(
            'Crear publicación',
            style: TextStyle(
              color: isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ),

            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
<path fill-rule="evenodd" d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25ZM6.262 6.072a8.25 8.25 0 1 0 10.562-.766 4.5 4.5 0 0 1-1.318 1.357L14.25 7.5l.165.33a.809.809 0 0 1-1.086 1.085l-.604-.302a1.125 1.125 0 0 0-1.298.21l-.132.131c-.439.44-.439 1.152 0 1.591l.296.296c.256.257.622.374.98.314l1.17-.195c.323-.054.654.036.905.245l1.33 1.108c.32.267.46.694.358 1.1a8.7 8.7 0 0 1-2.288 4.04l-.723.724a1.125 1.125 0 0 1-1.298.21l-.153-.076a1.125 1.125 0 0 1-.622-1.006v-1.089c0-.298-.119-.585-.33-.796l-1.347-1.347a1.125 1.125 0 0 1-.21-1.298L9.75 12l-1.64-1.64a6 6 0 0 1-1.676-3.257l-.172-1.03Z" clip-rule="evenodd" />
</svg>

                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LenguasScreen()),
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
                    MaterialPageRoute(builder: (context) => ServicioScreen()),
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
                    MaterialPageRoute(builder: (context) => ResidenciasScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: SvgPicture.string(
                  '''
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            </svg>
                  ''',
                  width: 26.0 * 1.1,
                  height: 26.0 * 1.1,
                  color: Color(0xFF006ef9),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OpcionesScreen()),
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

class PostTile extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final bool isDarkMode;
  final BuildContext context;

  PostTile({required this.doc, required this.isDarkMode, required this.context});

  // Eliminar publicación
  Future<void> _deletePost(String postId) async {
    try {
      // Elimina la publicación desde Firestore
      await FirebaseFirestore.instance.collection('posts_lenguas').doc(postId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Publicación eliminada', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar la publicación', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Mostrar el diálogo de confirmación de eliminación
  void _showDeleteConfirmationDialog(BuildContext context, bool isDarkTheme, String postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkTheme ? Color(0xFF000D1D) : Color(0xFFE7EFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Color(0xFFF006EF9)),
          ),
          title: Text(
            "Eliminar publicación",
            style: TextStyle(color: Color(0xFFF006EF9)),
          ),
          content: Text(
            "¿Estás seguro de que deseas eliminar este publicación?",
            style: TextStyle(color: Color(0xFFF006EF9)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Color(0xFFF006EF9)),
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text(
                "Eliminar",
                style: TextStyle(color: Color(0xFFFF2F4F)),
              ),
              onPressed: () {
                _deletePost(postId); 
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Detectar si el texto tiene un enlace y abrirlo
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }

  // Detectar y generar enlaces en el contenido
TextSpan _buildContentText(String content) {
  final urlPattern = r'([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}|https?://[^\s]+|\b(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}\b)';
  final regExp = RegExp(urlPattern);
  final matches = regExp.allMatches(content);

  final List<TextSpan> children = [];
  int lastMatchEnd = 0;

  // Agregar texto normal y enlaces
  for (var match in matches) {
    if (match.start > lastMatchEnd) {
      children.add(TextSpan(
        text: content.substring(lastMatchEnd, match.start),
        style: TextStyle(color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19)),
      ));
    }

    // Enlace detectado
    String url = match.group(0)!;
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "http://$url"; // Prevenir que URLs sin http sean lanzadas
    }

    children.add(TextSpan(
      text: url,
      style: TextStyle(color: const Color(0xFF006EF9), fontWeight: FontWeight.bold),
      recognizer: TapGestureRecognizer()..onTap = () => _launchURL(url),
    ));

    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < content.length) {
    children.add(TextSpan(
      text: content.substring(lastMatchEnd),
      style: TextStyle(color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19)),
    ));
  }

  return TextSpan(children: children);
}

@override
Widget build(BuildContext context) {
  final postData = doc.data() as Map<String, dynamic>;

  return GestureDetector(
    onTap: () {
  
    },
    child: Center(
      child: Container(
        width: 380.0,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      postData['email'] ?? 'Usuario desconocido',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Color(0xFF006ef9) : Color(0xFF006ef9),
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.verified, color: Color(0xFF009FF9), size: 18),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Color(0xFFFF2F4F)),
                  onPressed: () => _showDeleteConfirmationDialog(
                      context, isDarkMode, doc.id),
                ),
              ],
            ),
            SizedBox(height: 10),
            SelectableText(
              postData['title'] ?? 'Título de publicación',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19),
              ),
            ),
            SizedBox(height: 10),
            SelectableText.rich(
              _buildContentText(postData['content'] ?? 'Contenido de la publicación'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}
}