import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';

class FeelingOfTheDay extends StatelessWidget {
  final String? feeling;

  const FeelingOfTheDay({super.key, required this.feeling});

  @override
  Widget build(BuildContext context) {
    String emoji;
    switch (feeling) {
      case 'excellent':
        emoji = Emojis.starStruck;
        break;
      case 'good':
        emoji = Emojis.smilingFaceWithSmilingEyes;
        break;
      case 'average':
        emoji = Emojis.neutralFace;
        break;
      case 'poor':
        emoji = Emojis.disappointedFace;
        break;
      case 'terrible':
        emoji = Emojis.poutingFace;
        break;
      case 'tired':
        emoji = Emojis.tiredFace;
        break;
      case 'sad':
        emoji = Emojis.disappointedFace;
        break;
      default:
        emoji = Emojis.confusedFace;
    }

    return Text(emoji, style: const TextStyle(fontSize: 24));
  }
}
