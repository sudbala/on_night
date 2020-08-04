
import 'package:flutter/material.dart';

/// This BlankPage Widget is a completely Blank Widget with a custom listView
/// added to it in order to serve as our 'placeholder' screens for now
class Template extends StatefulWidget {
  Template({Key key}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Lorem Ipsum'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}