import 'dart:io';

import 'package:employee/ui/widgets/bottomBar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
            direction: Platform.isWindows ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'تم التطوير بواسطة المهندس غالي عبدالله',
                    style: TextStyle(fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'للتواصل',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '+963 968 487 557',
                        style: TextStyle(fontSize: 20),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  )
                ],
              )),
              Expanded(child: Image.asset('assets/ghale.png'))
            ]),
      ),
      bottomNavigationBar: const BottomBar(index: 1),
    );
  }
}
