import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/ink_custom_button.dart';

class StudentSubmitProposalPage extends StatelessWidget {
  static const String pageId = "/StudentSubmitProposalPage";

  const StudentSubmitProposalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Submit Proposal',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cover letter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Describe why do you fit to this project"),
            SizedBox(
              height: 20,
            ),
            TextField(
              minLines: 1,
              maxLines: 10,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkCustomButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Cancel",
                  height: 25,
                  width: (MediaQuery.of(context).size.width / 2.7),
                ),
                InkCustomButton(
                  onTap: () {},
                  title: "Submit proposal",
                  height: 25,
                  width: (MediaQuery.of(context).size.width / 2.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
