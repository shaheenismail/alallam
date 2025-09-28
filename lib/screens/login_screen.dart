import 'package:allallam/common/widgets/gradient_button_widget.dart';
import 'package:allallam/screens/otp_screen.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
   final height = size.height;
   final width = size.width;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
     // appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("ALALLAM",
            style: GoogleFonts.figtree(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 40.0),),
            SizedBox(height: 40,),
            TextField(controller: usernameController, decoration: InputDecoration(prefixIcon: Icon(EneftyIcons.user_outline) ,labelText: "Username")),
            SizedBox(height: 20,),
            TextField(controller: passwordController, decoration: InputDecoration(prefixIcon: Icon(EneftyIcons.password_check_outline),labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            CustomGradientButton(
  text: "Login",
  isLoading: auth.isLoading,
  onTap: () async {
    final error = await auth.login(
        usernameController.text, passwordController.text);
    if (error == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => OtpScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  },
),
          ],
        ),
      ),
    );
  }
}
