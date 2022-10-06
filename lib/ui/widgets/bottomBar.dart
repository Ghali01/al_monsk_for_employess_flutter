import 'package:employee/utils/colors.dart';
import 'package:employee/utils/routes.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int index;
  const BottomBar({Key? key, required this.index}) : super(key: key);
  static const pages = [Routes.profile, Routes.about];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: AppColors.blueGray,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'الملف الشخصي',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'حول التطبيق',
        ),
      ],
      onTap: (i) => Navigator.of(context).pushReplacementNamed(pages[i]),
    );
  }
}
