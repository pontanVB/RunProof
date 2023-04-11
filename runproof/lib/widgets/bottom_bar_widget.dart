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
    return BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 16, 47, 83),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: 'Tillbaka'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.arrow_forward),
              label: forwardText,
          )
        ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).pop();
            break;
          case 1:
            Navigator.push(
              context,
              nextPage);
            break;
        }
      }
    );
  }
}