import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CircleAvatar(
          child: IconButton(
              onPressed: () {
                onPressed();
              },
              icon: const Icon(Icons.add)
          )
        ),
      ],
    );
  }
}
