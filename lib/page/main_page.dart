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
    final bloc = BlocSupportWidget.of<MainBloc>(context);
    return CompatScaffold(
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
                delegate: _MainAppBar(),
                pinned: true,
              ),
              SliverPersistentHeader(
                delegate: _MainHeaderContent(),
                pinned: true,
              ),
              SliverGrid(
                delegate: _SliverGridChild(bloc).builderDelegate,
                gridDelegate: _sliverGridFormat()
              ),
            ],
          );
        }
    );
  }
}

class _MainAppBar extends SliverPersistentHeaderDelegate {
  static const double height = 80.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        alignment: Alignment.center,
        child: CompatAppBar(title: Text('Demo')),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _MainHeaderContent extends SliverPersistentHeaderDelegate {

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: compatThemePrimaryColor(context),
        alignment: Alignment.topCenter,
        child: CompatText('Header', style: TextStyle(color: Colors.white, fontSize: 30.0)));
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _SliverGridChild {
  _SliverGridChild(this.bloc) {
    _delegate = SliverChildBuilderDelegate(_widgetBuilder, childCount: mainGridPage.length);
  }

  final MainBloc bloc;
  SliverChildBuilderDelegate _delegate;

  get builderDelegate => _delegate;
  
  Widget _widgetBuilder(BuildContext context, int index) {
    final data = mainGridPage[index];
    return Column(
      children: <Widget>[
        _iconWidget(context, data, index),
        Text(data.title,
            style: TextStyle(color: data.routeName == null ? Colors.grey: Colors.black)),
      ],
    );
  }

  // 点击事件
  Widget _iconWidget(BuildContext context, GridPageContent data, int index) {
    if (data.routeName != null) {
      return _getIconButton(data, () {
        Navigator.of(context).pushNamed(data.routeName);
        bloc.viewJumpSink.add(index);
      });
    } else {
      return Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: _getIconButton(data, null),
      );
    }
  }

  Widget _getIconButton(GridPageContent data, VoidCallback onPressed) {
    return CompatIconButton(
        materialIcon: Icon(data.materialIcon),
        cupertinoIcon: Icon(data.cupertinoIcon),
        onPressed: onPressed,
    );
  }
}

SliverGridDelegate _sliverGridFormat() {
  return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0);
}
