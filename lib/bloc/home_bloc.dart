import 'dart:async';

import 'package:flutter_architecture/widget/bloc_support_widget.dart';

class HomeBloc implements BlocBase {
  // 处理触摸事件，以及对外通知
  StreamController<int> _touchController = StreamController<int>();
  StreamSink<int> get _inTouch => _touchController.sink;
  Stream<int> get outPageStream => _touchController.stream;

  // 实际跳转控制器
  StreamController<int> _viewJumpController = StreamController<int>();
  StreamSink get viewJumpSink => _viewJumpController.sink;

  HomeBloc(){
    _viewJumpController.stream
        .listen(_switchPage);
  }

  void dispose(){
    _viewJumpController.close();
    _touchController.close();
  }

  void _switchPage(int index){
    // switch page

    _inTouch.add(index);
  }
}            