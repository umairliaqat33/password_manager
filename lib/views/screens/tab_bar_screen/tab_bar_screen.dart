import 'package:flutter/material.dart';
import 'package:password_manager/views/screens/add_credentials/add_credentials.dart';
import 'package:password_manager/utils/colors.dart';
import 'package:password_manager/views/screens/home_Screen/home_screen.dart';
import 'package:password_manager/views/widgets/dialogues/sign_out_alert_dialogue.dart';
import 'package:password_manager/views/screens/password_creation_screen/password_creating_screen.dart';

import '../search_screen/search_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AddCredentials();
                  });
            },
            child: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Colors.red,
                ], begin: Alignment.topRight, end: Alignment.topLeft),
              ),
              child: const Icon(
                Icons.add,
                color: whiteColor,
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 20,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Colors.red,
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              ),
            ),
            title: const Text(
              "Password Manager",
              style: TextStyle(
                color: whiteColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  creatingSignOutAlertDialog(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: whiteColor,
                ),
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              indicatorWeight: 5,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 3),
              ),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.list,
                    color: whiteColor,
                  ),
                  child: Text(
                    "Password List",
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.password,
                    color: whiteColor,
                  ),
                  child: Text(
                    "Password generator",
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              PasswordCreation(),
            ],
          ),
        ),
      ),
    );
  }
}
