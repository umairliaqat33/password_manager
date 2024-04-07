import 'package:flutter/material.dart';
import 'package:password_manager/views/widgets/dialogues/view_dialogue.dart';
import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/repositories/firestore_repository.dart';
import 'package:password_manager/views/widgets/general_widgets/password_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PasswordModel?>>(
      stream: _firestoreRepository.getAllPasswords(),
      builder: (BuildContext context, snapshot) {
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
          return Column(
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
            ],
          );
        }
        List<PasswordModel?>? passwordList = snapshot.data;

        return ListView.builder(
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
                child: PasswordListCard(passwordModel: passwordList[index]!),
              );
            });
      },
    );
  }
}
