import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class CompanyAlreadyHaveProfileInputPage extends StatefulWidget {
  static const String pageId = "/CompanyAlreadyHaveProfileInputPage";

  const CompanyAlreadyHaveProfileInputPage({super.key});

  @override
  State<CompanyAlreadyHaveProfileInputPage> createState() => _CompanyAlreadyHaveProfileInputPageState();
}

class _CompanyAlreadyHaveProfileInputPageState extends State<CompanyAlreadyHaveProfileInputPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10,),
            const Center(
              child: Text(
                'Welcome to Student Hub',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
            const SizedBox(height: 20,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Company name"),
                _TextBox(hintText: "Enter your company name"),
            ],),
            const SizedBox(height: 20,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Website"),
                _TextBox(hintText: "http://"),
            ],),
            const SizedBox(height: 20,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description"),
                _TextBox(hintText: "Describe your company"),
            ],),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("How many people are in your company?"),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Text("It's just me"),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Cancel" được nhấn
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Edit" được nhấn
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextBox extends StatefulWidget {
  final String hintText; 

  const _TextBox({Key? key, required this.hintText}) : super(key: key);

  @override
  State<_TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<_TextBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('profileformHaveAcc_TextBox_input'),
      maxLines: null,
      decoration: InputDecoration(
        labelText: "",
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic, // Making the hint text italic
          color: Colors.grey[500], // Setting a light grey color for the hint
        ),
        errorText: false ?'invalid': null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        contentPadding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      ),
    );
  }
}