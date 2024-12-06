import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:votaciones/home_alumno.dart';
import 'package:votaciones/lenguas_alumnos.dart';
import 'package:votaciones/opciones_alumno.dart';
import 'package:votaciones/servicio_alumno.dart';
import 'dart:async';
import 'main.dart';

class ResidenciasScreen2 extends StatefulWidget {
  @override
  _ResidenciasScreenState2 createState() => _ResidenciasScreenState2();
}

class _ResidenciasScreenState2 extends State<ResidenciasScreen2> {
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
        stream: FirebaseFirestore.instance.collection('posts_practicas').orderBy('timestamp', descending: true).snapshots(),
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
              return PostTile(doc: doc, isDarkMode: isDarkMode,); 
            }).toList(),
          );
        },
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
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
          <path fill-rule="evenodd" d="M7.5 5.25a3 3 0 0 1 3-3h3a3 3 0 0 1 3 3v.205c.933.085 1.857.197 2.774.334 1.454.218 2.476 1.483 2.476 2.917v3.033c0 1.211-.734 2.352-1.936 2.752A24.726 24.726 0 0 1 12 15.75c-2.73 0-5.357-.442-7.814-1.259-1.202-.4-1.936-1.541-1.936-2.752V8.706c0-1.434 1.022-2.7 2.476-2.917A48.814 48.814 0 0 1 7.5 5.455V5.25Zm7.5 0v.09a49.488 49.488 0 0 0-6 0v-.09a1.5 1.5 0 0 1 1.5-1.5h3a1.5 1.5 0 0 1 1.5 1.5Zm-3 8.25a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z" clip-rule="evenodd" />
          <path d="M3 18.4v-2.796a4.3 4.3 0 0 0 .713.31A26.226 26.226 0 0 0 12 17.25c2.892 0 5.68-.468 8.287-1.335.252-.084.49-.189.713-.311V18.4c0 1.452-1.047 2.728-2.523 2.923-2.12.282-4.282.427-6.477.427a49.19 49.19 0 0 1-6.477-.427C4.047 21.128 3 19.852 3 18.4Z" />
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

class PostTile extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  final bool isDarkMode;

  PostTile({required this.doc, required this.isDarkMode});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false; 
    _checkIfFavorite(); 
  }

  Future<void> _checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePosts = prefs.getStringList('favoritePosts') ?? [];
    setState(() {
      isFavorite = favoritePosts.contains(widget.doc.id);
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePosts = prefs.getStringList('favoritePosts') ?? [];

    setState(() {
      if (isFavorite) {
        favoritePosts.remove(widget.doc.id);
      } else {
        favoritePosts.add(widget.doc.id); 
      }
      isFavorite = !isFavorite; 
    });

    await prefs.setStringList('favoritePosts', favoritePosts);
  }

  // Detectar si el texto tiene un enlace y abrirlo
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  // Detectar y generar enlaces en el contenido
  TextSpan _buildContentText(String content) {
    final urlPattern =
        r'([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}|https?://[^\s]+|\b(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}\b)';
    final regExp = RegExp(urlPattern);
    final matches = regExp.allMatches(content);

    final List<TextSpan> children = [];
    int lastMatchEnd = 0;

    for (var match in matches) {
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(
          text: content.substring(lastMatchEnd, match.start),
          style: TextStyle(
              color: widget.isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19)),
        ));
      }

      String url = match.group(0)!;
      if (!url.startsWith("http://") && !url.startsWith("https://")) {
        url = "http://$url";
      }

      children.add(TextSpan(
        text: url,
        style: TextStyle(
            color: const Color(0xFF006EF9), fontWeight: FontWeight.bold),
        recognizer: TapGestureRecognizer()..onTap = () => _launchURL(url),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < content.length) {
      children.add(TextSpan(
        text: content.substring(lastMatchEnd),
        style: TextStyle(
            color: widget.isDarkMode ? Color(0xFFE7EFFF) : Color(0xFF000D19)),
      ));
    }

    return TextSpan(children: children);
  }

  @override
  Widget build(BuildContext context) {
    final postData = widget.doc.data() as Map<String, dynamic>;

    return GestureDetector(
      child: Center(
        child: Container(
          width: 380.0,
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.isDarkMode ? Color(0xFF000D19) : Color(0xFFE7EFFF),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Color(0xFF006ef9)),
            boxShadow: [
              BoxShadow(
                color: widget.isDarkMode ? Color(0x500070F9) : Color(0x500070F9),
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
                          color: widget.isDarkMode
                              ? Color(0xFF006ef9)
                              : Color(0xFF006ef9),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.verified, color: Color(0xFF009FF9), size: 18),
                    ],
                  ),
                 
            
                IconButton(
                  icon: SvgPicture.string(
                    isFavorite
                        ? '''
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                          <path fill-rule="evenodd" d="M6.32 2.577a49.255 49.255 0 0 1 11.36 0c1.497.174 2.57 1.46 2.57 2.93V21a.75.75 0 0 1-1.085.67L12 18.089l-7.165 3.583A.75.75 0 0 1 3.75 21V5.507c0-1.47 1.073-2.756 2.57-2.93Z" clip-rule="evenodd" />
                        </svg>
                        '''
                        : '''
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                        </svg>
                        ''',
                    color: const Color(0xFFFAAB00), 
                  ),
                  onPressed: _toggleFavorite,
                )

                ],
              ),
              SizedBox(height: 10),
              Text(
                postData['title'] ?? 'Título de publicación',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode
                      ? Color(0xFFE7EFFF)
                      : Color(0xFF000D19),
                ),
              ),
              SizedBox(height: 10),
              SelectableText.rich(
                _buildContentText(postData['content'] ?? 'Contenido de la publicación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


