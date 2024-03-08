import 'package:flutter/material.dart';

class InkCustomButton extends StatelessWidget {
  const InkCustomButton(
      {Key? key,
      this.onTap,
      required this.title,
      this.width,
      this.height,
      this.padding})
      : super(key: key);

  final Function()? onTap;
  final String title;
  final double? width;
  final double? height;
  final double? padding;

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
          padding: EdgeInsets.all(padding == 0 ? 0 : padding!),
          height: height == 0 ? 40 : height,
          width: width == 0 ? (MediaQuery.of(context).size.width / 2) : width,
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
