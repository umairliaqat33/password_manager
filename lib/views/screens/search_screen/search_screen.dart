import 'package:flutter/material.dart';

import 'package:password_manager/config/size_config.dart';
import 'package:password_manager/views/widgets/dialogues/view_dialogue.dart';
import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/repositories/firestore_repository.dart';
import 'package:password_manager/utils/colors.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/views/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:password_manager/views/widgets/general_widgets/password_list_card.dart';
import 'package:password_manager/views/widgets/text_fields/text_form_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = "";
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  final TextEditingController _searchController = TextEditingController();
  Stream<List<PasswordModel?>>? _passwordSearchStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TabBarScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: const Text(
          "Search Passwords",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SizedBox(
        height: SizeConfig.height(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width15(context) + 1,
                  right: SizeConfig.width15(context) + 1,
                ),
                child: TextFormFieldWidget(
                  controller: _searchController,
                  validator: (value) => Utils.simpleValidator(value),
                  label: "",
                  hintText: "Enter article name to search",
                  inputAction: TextInputAction.done,
                  onChanged: (value) => _searchOnchaged(),
                ),
              ),
              StreamBuilder<List<PasswordModel?>>(
                stream: _passwordSearchStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No passwords yet!",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 200,
                                child: Image.asset(
                                  "image/waiting.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Material(
                                color: Colors.purple,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                elevation: 5.0,
                                child: MaterialButton(
                                  onPressed: () {},
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: const Text(
                                    'Add credentials',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  List<PasswordModel?>? passwordList = snapshot.data;
                  return SizedBox(
                    height: SizeConfig.height20(context) * 32,
                    child: ListView.builder(
                        itemCount: passwordList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              createDialogBox(
                                context: context,
                                email: passwordList[index]!.email,
                                username: passwordList[index]!.userName,
                                password: passwordList[index]!.password,
                                website: passwordList[index]!.website,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.width15(context) + 1,
                                right: SizeConfig.width15(context) + 1,
                              ),
                              child: PasswordListCard(
                                passwordModel: passwordList[index]!,
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchOnchaged() {
    _passwordSearchStream =
        _firestoreRepository.searchPasswords(_searchController.text);
    setState(() {});
  }
}
