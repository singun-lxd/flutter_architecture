import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/main_bloc.dart';
import 'package:flutter_architecture/page/main_page.dart';
import 'package:flutter_architecture/page/page_routes.dart';
import 'package:flutter_architecture/widget/bloc_support_widget.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CompatApp(
      title: 'Flutter Architecture',
      material: (_) => MaterialAppData(theme: ThemeData(
        primarySwatch: Colors.pink,
      )),
      cupertino: (_) => CupertinoAppData(theme: CupertinoThemeData(
        primaryColor: Colors.pink,
      )),
      home: BlocSupportWidget<MainBloc>(
        bloc: MainBloc(),
        child: MainPage(),
      ),
      routes: globalPageRoutes,
    );
  }
}

