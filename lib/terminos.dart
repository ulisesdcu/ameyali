import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart'; 

class TerminosScreen extends StatelessWidget {
  const TerminosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000D1D),
      appBar: AppBar(
        backgroundColor: Color(0xFF000D1D),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.string(
            '''
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
        <path stroke-linecap="round" stroke-linejoin="round" d="M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3" />
        </svg>

            ''',
            width: 26.0 * 1.1,
            height: 26.0 * 1.1,
            color: Color(0xFF006EF9),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/ameyali.svg',
                  color: Color(0xFF006EF9),
                  width: 80, 
                ),
                SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/icon/tec.svg',
                  color: Color(0xFF006EF9),
                  width: 95, 
                ),
              ],
            ),
            SizedBox(height: 20),
           
            RichText(
              text: TextSpan(
                children: [
               
                  TextSpan(
                    text: 'Términos y condiciones\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 
                  TextSpan(
                    text: '1. Aceptación de términos.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Al descargar y utilizar la aplicación Ameyali desarrollada por el Tecnológico Nacional de México Instituto Ciudad Valles para la oficina de Gestión Tecnológica y Vinculación, aceptas y te comprometes a cumplir los términos y condiciones aquí descritos. Si no estás de acuerdo con estos términos, por favor, no utilices esta aplicación.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                
                  TextSpan(
                    text: '2. Objetivo de la aplicación.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Ameyali es una aplicación de acceso exclusivo para los alumnos del Instituto, diseñada para brindar información referente a:\n\n'
                        '- Lenguas Extranjeras y Maternas\n'
                        '- Servicio Social\n'
                        '- Prácticas Profesionales\n\n'
                        'Cada sección incluye detalles sobre formatos, documentación y procesos necesarios en cada tema.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                 
                  TextSpan(
                    text: '3. Acceso y uso de la aplicación.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'La aplicación solo permite el acceso a usuarios de la comunidad escolar del Instituto mediante la autenticación con un correo institucional que contenga el dominio @tecvalles.mx. Es necesario proporcionar una contraseña, creada por el propio usuario, para garantizar la privacidad y seguridad de su cuenta. No se requerirá información adicional ni se almacenarán datos personales no solicitados explícitamente para el funcionamiento de la app.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                 
                  TextSpan(
                    text: '4. Responsabilidad del usuario.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'El usuario es responsable de la confidencialidad de su correo institucional y de su contraseña. Cualquier actividad realizada desde una cuenta es responsabilidad del propietario de dicha cuenta. Se recomienda no compartir tus credenciales de acceso. El mal uso de la información proporcionada por la aplicación o el acceso no autorizado a otras cuentas se considera una violación de estos términos.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                
                  TextSpan(
                    text: '5. Privacidad y protección de datos.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'La aplicación recopila exclusivamente el correo institucional y la contraseña para fines de autenticación. Ninguna información personal o académica adicional será solicitada o almacenada en la aplicación. Los datos proporcionados están protegidos conforme a las políticas de privacidad vigentes del Tecnológico Nacional de México Instituto Ciudad Valles y no serán compartidos con terceros.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
               
                  TextSpan(
                    text: '6. Restricciones de uso.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Queda prohibido intentar acceder o manipular secciones de la aplicación para las que no se tenga autorización. No está permitido el uso de la aplicación con fines comerciales o lucrativos ni la extracción masiva de datos. Cualquier uso indebido de la aplicación puede derivar en la suspensión o eliminación del acceso.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              
                  TextSpan(
                    text: '7. Modificaciones en términos y condiciones.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'El Tecnológico Nacional de México Instituto Ciudad Valles se reserva el derecho de actualizar o modificar estos términos en cualquier momento. En caso de cambios significativos, se notificará a los usuarios mediante un aviso en la aplicación o por otros medios de comunicación oficiales.\n\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
               
                  TextSpan(
                    text: '8. Contacto.\n\n',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Para cualquier duda, aclaración o problema relacionado con el uso de Ameyali, puede contactar a la oficina de Gestión Tecnológica y Vinculación del Instituto a través de los medios oficiales del Tecnológico Nacional de México Instituto Ciudad Valles publicados en ',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                
                  TextSpan(
                    text: 'tecvalles.mx',
                    style: TextStyle(
                      color: Color(0xFF006EF9), 
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, 
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        const url = 'https://www.tecvalles.mx/wp/horario-de-atencion-gestion-tecnologica-y-vinculacion/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      color: Color(0xFFE7EFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.justify, 
            ),
          ],
        ),
      ),
    );
  }
}
