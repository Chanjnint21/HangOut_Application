import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      backgroundColor: const Color(0xFF3b3b3b),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/hangout.png'),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFC9652),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(
                        width: 8), // Adjust the spacing between icon and text
                    Text(
                      'Home',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                onSelectScreen('home');
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFC9652),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit_document,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(
                        width: 8), // Adjust the spacing between icon and text
                    Text(
                      'Draft',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                onSelectScreen('draft');
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFC9652),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(
                        width: 8), // Adjust the spacing between icon and text
                    Text(
                      'profile',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                onSelectScreen('profile');
              },
            ),
          ),
          Spacer(), // Add Spacer to push the logout button to the bottom
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFC9652),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(
                        width: 8), // Adjust the spacing between icon and text
                    Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
