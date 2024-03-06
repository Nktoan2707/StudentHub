import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }
}

class PrimaryText extends StatelessWidget {
  const PrimaryText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
    );
  }
}


class TextFieldBox extends StatelessWidget {
  const TextFieldBox(
      {super.key, required this.heightBox, required this.textController});

  final double heightBox;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: SizedBox(
        height: heightBox,
        child: TextField(
          controller: textController,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}