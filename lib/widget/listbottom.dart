import 'package:flutter/material.dart';

class ListBottomNavigator extends StatelessWidget {
  const ListBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        //borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: [
          // BottomNavigationBarItem(
          //     icon: IconButton(
          //       onPressed: () {},
          //       icon: Image.asset('assets/flower-fill.png',
          //           width: 25, height: 25, fit: BoxFit.cover),
          //     ),
          //     label: ''),
          // BottomNavigationBarItem(
          //     icon: IconButton(
          //       onPressed: () {},
          //       icon: Image.asset('assets/flower-fill.png',
          //           width: 25, height: 25, fit: BoxFit.cover),
          //     ),
          //     label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                color: const Color.fromARGB(255, 207, 210, 217),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.view_list, size: 25),
                onPressed: () {
                  Navigator.pushNamed(context, '/list');
                },
                color: const Color.fromARGB(255, 43, 135, 79),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {
                  Navigator.pushNamed(context, '/my');
                },
                color: const Color.fromARGB(255, 207, 210, 217),
              ),
              label: ''),
        ],
      ),
    );
  }
}
