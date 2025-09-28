import 'package:allallam/common/widgets/gradient_button_widget.dart';
import 'package:allallam/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;

    
    Color accentPurpleColor = Color(0xFF6A53A1);
    Color accentYellowColor = Color(0xFFFFB612);
    Color accentDarkGreenColor = Color(0xFF115C49);
    Color accentOrangeColor = Color(0xFFEA7A3B);
    Color accentPinkColor = Color(0xFFF99BBD);


    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.titleLarge?.copyWith(color: color, fontWeight: FontWeight.bold);
    }

    List<TextStyle?> otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Otp send to your register whatsapp number.",
            style: GoogleFonts.figtree(color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w600),),
            SizedBox(height: 20),
            OtpTextField(
              numberOfFields: 6,
              borderColor: accentPurpleColor,
              focusedBorderColor: accentPurpleColor,
              styles: otpTextStyles,
              showFieldAsBox: false,
              borderWidth: 2.0,
              onCodeChanged: (String code) {
                otpCode = code;
              },
              onSubmit: (String verificationCode) {
                otpCode = verificationCode;
              },
            ),
            SizedBox(height: 20),

            CustomGradientButton(
              text: "Verify OTP",
              isLoading: auth.isLoading,
              onTap: () async {
                final error = await auth.verifyOtp(otpCode);
                if (error == null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()),
                    (route) => false,
                  );
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
