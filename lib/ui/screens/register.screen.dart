import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController userNameController =
      TextEditingController(); // New name controller
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referrerCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userNameController, // Name field
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: referrerCodeController,
              decoration: InputDecoration(labelText: 'Referrer Code'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final userName = userNameController.text;
                final password = passwordController.text;
                final referrerCode = referrerCodeController.text;

                if (userName.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill required fields')),
                  );
                  return;
                }

                try {
                  // Call the register function, navigation will be handled by notifyListeners
                  await Provider.of<AuthProvider>(context, listen: false)
                      .register(
                    userName,
                    password,
                    "",
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration failed: $error')),
                  );
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
