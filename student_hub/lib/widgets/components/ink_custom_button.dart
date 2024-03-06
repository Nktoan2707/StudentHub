import 'package:flutter/material.dart';


class InkCustomButton extends StatelessWidget {
  const InkCustomButton({Key? key, this.onTap, required this.title})
      : super(key: key);

  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 6),
            color: Colors.black.withOpacity(1),
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          )),
        ),
      ),
    );
  }
}
