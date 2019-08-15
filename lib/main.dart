import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/home_bloc.dart';
import 'package:flutter_architecture/page/home_page.dart';
import 'package:flutter_architecture/page/page_routes.dart';
import 'package:flutter_architecture/widget/bloc_support_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CompatApp(
      title: 'Flutter Architecture',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      material: (_) => MaterialAppData(theme: ThemeData(
        primarySwatch: Colors.green,
      )),
      cupertino: (_) => CupertinoAppData(theme: CupertinoThemeData(
        primaryColor: Colors.green,
      )),
      home: BlocSupportWidget<HomeBloc>(
        bloc: HomeBloc(),
        child: HomePage(),
      ),
      routes: globalPageRoutes,
    );
  }
}

