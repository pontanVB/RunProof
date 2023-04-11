import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget(
      {super.key,
      required this.title,
      required this.forwardText,
      required this.nextPage});

  final String title;
  final String forwardText;
  final MaterialPageRoute nextPage;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 16, 47, 83),
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 0,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 165, 39, 75),
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('TILLBAKA')),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 7,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02)),
                  onPressed: () => Navigator.push(context, nextPage),
                  child: Text(forwardText)),
            ),
          ],
        ),
      ),
    );
  }
}
