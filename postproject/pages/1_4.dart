import 'package:flutter/material.dart';
import 'package:student_hub/widgets/components/ui_extension.dart';
import 'package:student_hub/widgets/components/top_navigation_bar.dart';
class Page14 extends StatefulWidget {
  const Page14({super.key});

  @override
  State<Page14> createState() => _Page14State();
}

class _Page14State extends State<Page14> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "1/4   Let's start with a strong title",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                const Text("This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!"),
                _title(),
                SizedBox(height: 15,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Example titles",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'Build responsive WordPress site with booking/payment functionality\n',
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(Icons.fiber_manual_record, size: 5),
                        ),
                      ),
                      TextSpan(
                        text: 'Facebook ad specialist need for product launch\n',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                NextScope(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _title extends StatefulWidget {
  const _title({super.key});

  @override
  State<_title> createState() => _titleState();
}

class _titleState extends State<_title> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signup_fullnameInput_textField'),
      onChanged: (title){},
      decoration: InputDecoration(
        labelText: "write a title for jour post",
        errorText: false ?'invalid title': null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
      ),
    );
  }
}

class NextScope extends StatefulWidget {
  const NextScope({super.key});

  @override
  State<NextScope> createState() => _NextScopeState();
}

class _NextScopeState extends State<NextScope> {
  @override
  Widget build(BuildContext context) {
    return false
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('postProject_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: Size.fromHeight(30),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
              ),
            ),
            onPressed: true ? () {} : null,
            child: const Text('Next Scope'),
          );
  }
}