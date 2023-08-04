import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  CardItem({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              icon,
              size: 40,
              color: const Color.fromARGB(255, 83, 100, 255),
            )),
            const SizedBox(height: 8),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Center(
                child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
