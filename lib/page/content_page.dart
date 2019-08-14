import 'package:flutter/widgets.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CompatScaffold(
      appBar: CompatAppBar(
          title: Text('Content Page')
      ),
      body: Center(child: CompatText("Test"))
    );
  }
}