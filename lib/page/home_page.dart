import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/bloc/home_bloc.dart';
import 'package:flutter_architecture/page/home_grid_items.dart';
import 'package:flutter_architecture/widget/bloc_support_widget.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSupportWidget<HomeBloc>(
      bloc: HomeBloc(),
      child: HomeLayout(),
    );
  }
}

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocSupportWidget.of<HomeBloc>(context);
    return CompatScaffold(
      appBar: CompatAppBar(
        title: Text('Demo'),
        trailingActions: <Widget>[
          CompatIconButton(
            materialIcon: Icon(Icons.share),
            cupertinoIcon: Icon(CupertinoIcons.share),
            onPressed: () {

            },
          ),
          _buildMenu(),
        ],
      ),
      body: _buildPageStream(bloc),
      cupertinoContentPadding: true,
    );
  }

  Widget _buildMenu() {
    return Material(
      child: PopupMenuButton<int>(
        icon: Icon(
            isMaterial ? Icons.more_vert: CupertinoIcons.ellipsis),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 1,
            child: Text("Upgrade"),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text("Settings"),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Text("About"),
          )
        ],
        onSelected: (int value) {

        },
      )
    );
  }

  Widget _buildPageStream(HomeBloc bloc) {
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
                delegate: _SliverGridChild(bloc).builderDelegate,
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
    _delegate = SliverChildBuilderDelegate(_widgetBuilder, childCount: homeGridPage.length);
  }

  final HomeBloc bloc;
  SliverChildBuilderDelegate _delegate;

  get builderDelegate => _delegate;

  // 每一个Grid项的布局定义
  Widget _widgetBuilder(BuildContext context, int index) {
    final data = homeGridPage[index];
    return Column(
      children: <Widget>[
        _iconWidget(context, data, index),
        Text(data.title,
            style: TextStyle(color: data.routeName == null ? Colors.grey: Colors.black)),
      ],
    );
  }

  // 按钮点击事件处理
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
