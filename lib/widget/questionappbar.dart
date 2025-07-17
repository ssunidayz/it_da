import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuestionAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      centerTitle: true,
      backgroundColor: const Color.fromARGB(1, 249, 250, 245),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 110, 109, 109),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Image.asset(
        'assets/it_da_logo.png',
        fit: BoxFit.contain,
        height: 40,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 110, 109, 109),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
