import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Centered Logo
              Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                width: 150, // Adjust logo size as needed
                height: 150,
              ),
              const SizedBox(height: 20),
              // Centered TextField
              SizedBox(
                width: 300, // Adjust width as needed
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your text here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Google Sign-in Button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Google Sign-in logic here
                  print('Sign in with Google pressed');
                },
                icon: Image.asset(
                  'assets/google_logo.png', // Replace with your Google logo asset path
                  width: 24,
                  height: 24,
                ),
                label: const Text('Sign in with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
