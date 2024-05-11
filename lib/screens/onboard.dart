import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});
  Future<User?> _signInAnonmusly() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      final User? user = userCredential.user;
      print("Signed in with temporary account.");
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
          print(e);
      }
    }
    return null;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F9),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to our App!',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontFamily: "Outfit",
                color: const Color(0xFF161C24),
                fontSize: 57.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Text(
                'Get started by exploring our services or contacting us for more information.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: 'Manrope',
                  color: const Color(0xFF636F81),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: TextButton(
                  onPressed: ()async {
                    User? user = await _signInAnonmusly();
                    if(user!=null){}
                  },
                  child: Text(
                      "Get Started",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(2),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(200.0, 50.0), // Button width and height
                    ),
                  backgroundColor:MaterialStateProperty.all<Color>(Color(0xFF2797FF)),
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}
