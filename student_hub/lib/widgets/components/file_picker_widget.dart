import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class FilePickerWidget extends StatefulWidget {
  final String? uploadedFileName;

  const FilePickerWidget(
      {super.key, required this.onSelectedFileWithFilePath, this.uploadedFileName});

  final Function(String filePath) onSelectedFileWithFilePath;

  @override
  // ignore: library_private_types_in_public_api
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String? _fileName;

  Future<void> _openFilePicker() async {
    String? filePath = await FilePicker.platform.pickFiles().then((value) {
      if (value != null) {
        return value.files.single.path;
      } else {
        return null;
      }
    });

    if (filePath != null) {
      setState(() {
        widget.onSelectedFileWithFilePath(filePath);
        _fileName = basename(filePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: (MediaQuery.of(context).size.width) - 40,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _openFilePicker,
                child: const Text('Open File Picker'),
              ),
              const SizedBox(height: 20),
              _fileName != null
                  ? Text('Selected File: $_fileName')
                  : widget.uploadedFileName != null
                      ? Text('Uploaded File: ${widget.uploadedFileName}')
                      : const Text('No file selected'),
            ],
          ),
        ),
      )
    ]);
  }
}
