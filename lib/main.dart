import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'services/field_service.dart'; // Field servis import
import 'services/plant_service.dart'; // Plant servis import
import 'services/irrigation_plan_service.dart'; // Irrigation Plan servis import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlat
  runApp(const MyApp()); // MyApp'i const olarak çalıştır
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const eklendi

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthScreen(), // const eklendi
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key}); // const eklendi

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FieldService _fieldService = FieldService();
  final PlantService _plantService = PlantService();
  final IrrigationPlanService _irrigationPlanService = IrrigationPlanService();

  String _email = '';
  String _password = '';
  String _message = '';

  // Kullanıcı kayıt işlemi
  Future<void> _registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      setState(() {
        _message = 'Registration Successful';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = 'Auth Error: ${e.code} - ${e.message}';
      });
    } catch (e) {
      setState(() {
        _message = 'General Error: ${e.toString()}';
      });
    }
  }

  // Kullanıcı giriş işlemi
  Future<void> _loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      setState(() {
        _message = 'Login Successful';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = 'Auth Error: ${e.code} - ${e.message}';
      });
    } catch (e) {
      setState(() {
        _message = 'General Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _email = value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _password = value,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Text(_message),

            // Field, Plant ve Irrigation Plan CRUD işlemlerini test etmek için butonlar
            ElevatedButton(
              onPressed: () async {
                try {
                  await _fieldService.addField(
                    'UserID_1',
                    'Elma Bahçesi',
                    38.5,
                    27.2,
                  );
                } catch (e) {
                  setState(() {
                    _message = 'Field Error: ${e.toString()}';
                  });
                }
              },
              child: const Text('Add Field'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _plantService.addPlant(
                    'FieldID_1',
                    'Elma Ağacı',
                    'Meyve',
                  );
                } catch (e) {
                  setState(() {
                    _message = 'Plant Error: ${e.toString()}';
                  });
                }
              },
              child: const Text('Add Plant'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _irrigationPlanService.addIrrigationPlan(
                    'FieldID_1',
                    '2025-03-01 06:00:00',
                    100,
                  );
                } catch (e) {
                  setState(() {
                    _message = 'Irrigation Plan Error: ${e.toString()}';
                  });
                }
              },
              child: const Text('Add Irrigation Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
