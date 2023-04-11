import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key,
    required this.title,
    required this.forwardText,
    required this.nextPage

  });

  final String title;
  final String forwardText;
  final MaterialPageRoute nextPage;


  @override
  Widget build(BuildContext context){
    return BottomAppBar(
        color: const Color.fromARGB(255, 16, 47, 83),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 165, 39, 75)
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('TILLBAKA')),
            const Spacer(),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                onPressed: () => Navigator.push(context, nextPage),
                child: Text(forwardText)),
            const Spacer()
          ],
        ),
    );
  }
}