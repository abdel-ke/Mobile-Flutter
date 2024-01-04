import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtonIcon extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String logo;
  final double size;

  const MyButtonIcon(
      {super.key,
      required this.onTap,
      required this.title,
      required this.logo,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.transparent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Image(image: AssetImage(logo), height: 25),
            const SizedBox(
              width: 25,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size,
                fontFamily: GoogleFonts.dancingScript().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
