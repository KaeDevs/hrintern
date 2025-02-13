import 'package:flutter/material.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class Testscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () async {
          await showReleaseNotesDialog(context);
      
          }, child: Text("click"))
        ],
      ),
    );
  }

}