import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
      accentColor: Colors.orangeAccent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        bodyText1: TextStyle(fontSize: 16),
      ),
    ),
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  void _checkCredentials() {
    if (_emailController.text == "test@stanch.io" &&
        _passwordController.text == "Test@123") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen()),
      );
    }
  }

  void _onInputChange() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login", style: TextStyle(fontSize: 24))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (value) => _onInputChange(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              obscureText: true,
              onChanged: (value) => _onInputChange(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _checkCredentials : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, 
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final List<String> items = List.generate(5, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items", style: TextStyle(fontSize: 24))),
      body: SingleChildScrollView(
        child: Column(
          children: items.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DescriptionScreen(item: item)),
                );
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  title: Text(item, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  leading: Image.network('https://via.placeholder.com/150'), 
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DescriptionScreen extends StatelessWidget {
  final String item;

  DescriptionScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item, style: TextStyle(fontSize: 24))),
      body: Center(
        child: Text("Description of $item", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share", style: TextStyle(fontSize: 24))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://via.placeholder.com/150'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Share.share('Check out this item!');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text("Share this item"),
            ),
          ],
        ),
      ),
    );
  }
}
