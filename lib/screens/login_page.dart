import 'package:diaryapptest/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/main': (context) => MainPage(
              toggleDarkMode: (bool) {
                context;
              },
            ),
        // Define other routes here
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'lib/img/app_icon.svg',
                  width: 78.0,
                  height: 108.0,
                ),
                SizedBox(height: 26),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(47, 203, 249, 1)),
                    ),
                    labelText: 'Kullanıcı adı:',
                    labelStyle: TextStyle(color: Color.fromRGBO(99, 99, 99, 1)),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(47, 203, 249, 1)),
                    ),
                    labelText: 'Şifre:',
                    labelStyle: TextStyle(color: Color.fromRGBO(99, 99, 99, 1)),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                  child: Text('Giriş Yap'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Şifreni mi unuttun?'),
                ),
                SizedBox(height: 20),
                Text('Ya da',
                    style: TextStyle(color: Color.fromRGBO(99, 99, 99, 1))),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Google ile giriş yap'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Facebook ile giriş yap'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text('Hesabın yok mu? Kayıt Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
