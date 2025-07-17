import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text("test AppBar"),
//     );
//   }
// }
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
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
    );
  }
}
