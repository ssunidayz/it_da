import 'package:flutter/material.dart';

class ListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(1, 249, 250, 245),
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
