import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({Key? key, required this.message, required this.user, required this.onPressed})
      : super(key: key);
  final String message;
  final String user;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          CircleAvatar(
            child: Text('${message.substring(0,1)}${user.substring(0,1)}'),
          ),
          const SizedBox(
            width: 16,
          ),
          TextButton(
              onPressed: () {
                onPressed();
              },
            child: Text('$message $user', style: const TextStyle(color: Colors.black)),

          ),
        ],
      );
  }
}
