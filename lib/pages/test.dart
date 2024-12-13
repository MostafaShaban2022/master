import 'package:flutter/material.dart';

final ValueNotifier<int> number = ValueNotifier(0);

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                number.value += 1;
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 22,
              ),
            ),
            IconButton(
              onPressed: () {
                number.value -= 1;
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
                size: 22,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ValueListenableBuilder(
              valueListenable: number,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(
                  '$value',
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
