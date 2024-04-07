import 'package:flutter/material.dart';
import 'package:password_manager/models/password_model/password_model.dart';
import 'package:password_manager/views/screens/delete_credentials/delete_alert_dialogue.dart';
import 'package:password_manager/views/widgets/dialogues/update_dialogue.dart';

class PasswordListCard extends StatelessWidget {
  const PasswordListCard({
    super.key,
    required this.passwordModel,
  });

  final PasswordModel passwordModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text(
                      passwordModel.website,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      passwordModel.userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      passwordModel.email,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      createUpdateDialogBox(
                        context: context,
                        email: passwordModel.email,
                        username: passwordModel.userName,
                        password: passwordModel.password,
                        website: passwordModel.website,
                      );
                    },
                    icon: const Icon(
                      Icons.edit_note,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      creatingDeleteAlertDialog(
                        context: context,
                        website: passwordModel.website,
                        userName: passwordModel.userName,
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
