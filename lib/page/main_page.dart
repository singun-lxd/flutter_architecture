
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/bloc/main_bloc.dart';
import 'package:flutter_architecture/page/main_grid_items.dart';
import 'package:flutter_architecture/widget/bloc_support_widget.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSupportWidget<MainBloc>(
      bloc: MainBloc(),
      child: MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocSupportWidget.of<MainBloc>(context);
    return CompatScaffold(
      appBar: CompatAppBar(
          title: Text('Architecture Demo')
      ),
      body: _buildPageStream(bloc),
    );
  }

  Widget _buildPageStream(MainBloc bloc) {
    return StreamBuilder<int>(
        stream: bloc.outPageStream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          print('You choose: ${snapshot.data} page');
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: _MainHeaderContent(),
              ),
              SliverGrid(
                  delegate: _sliverGridContent(bloc),
                  gridDelegate: _sliverGridFormat()
              ),
            ],
          );
        }
    );
  }
}

class _MainHeaderContent extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.pink,
        alignment: Alignment.topCenter,
        child: Text('Header', style: TextStyle(color: Colors.white, fontSize: 30.0)));
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

SliverChildBuilderDelegate _sliverGridContent(MainBloc bloc) {
  Widget widgetBuilder(BuildContext context, int index) {
    var data = mainGridPage[index];
    return CompatIconButton(
      icon: Icon(data.icon),
      onPressed: () {
        Navigator.of(context).pushNamed(data.routeName);
        bloc.viewJumpSink.add(index);
      },
    );
  }

  return SliverChildBuilderDelegate(widgetBuilder, childCount: mainGridPage.length);
}

SliverGridDelegateWithFixedCrossAxisCount _sliverGridFormat() {
  final int mainGridCrossAxisCount = 3;
  final double mainGridMainAxisSpacing = 10.0;
  final double mainGridCrossAxisSpacing = 10.0;

  return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: mainGridCrossAxisCount,
      mainAxisSpacing: mainGridMainAxisSpacing,
      crossAxisSpacing: mainGridCrossAxisSpacing);
}
