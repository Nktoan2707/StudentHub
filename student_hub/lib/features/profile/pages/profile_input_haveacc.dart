import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';

class ProfileHaveAccPage extends StatefulWidget {
  const ProfileHaveAccPage({super.key});

  @override
  State<ProfileHaveAccPage> createState() => _ProfileHaveAccPageState();
}

class _ProfileHaveAccPageState extends State<ProfileHaveAccPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Center(
              child: Text('Welcome to Student Hub'),
            ),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Company name"),
                _TextBox(),
            ],),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Website"),
                _TextBox(),
            ],),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description"),
                _TextBox(),
            ],),
            SizedBox(height: 20,),
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
                    Text("It's just me"),
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
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Edit" được nhấn
                  },
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10),
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

class _TextBox extends StatefulWidget {
  const _TextBox({super.key});

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
        errorText: false ?'invalid': null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        contentPadding: EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}