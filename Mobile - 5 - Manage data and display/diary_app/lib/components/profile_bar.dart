import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blueAccent,
              width: 2.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image(
              height: 100,
              image: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(FirebaseAuth.instance.currentUser!.displayName!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 32)),
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Icon(Icons.logout, size: 32),
        ),
      ]),
    );
  }
}
