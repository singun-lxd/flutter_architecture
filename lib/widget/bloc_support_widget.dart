import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocSupportWidget<T extends BlocBase> extends StatefulWidget {
  BlocSupportWidget({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocSupportWidgetState<T> createState() => _BlocSupportWidgetState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BlocSupportWidget<T>>();
    BlocSupportWidget<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocSupportWidgetState<T> extends State<BlocSupportWidget<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}