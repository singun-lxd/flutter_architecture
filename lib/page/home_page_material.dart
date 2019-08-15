
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

MaterialScaffoldData mainPageMaterialData() => MaterialScaffoldData(
    body: Row(children: [
      SliverToBoxAdapter(
          child: Container(
              color: Colors.black12,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(children: <Widget>[
                Divider(height: 2.0, color: Colors.black54),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset('images/app_bar_hor.jpg', fit: BoxFit.cover),
                    Text('我是一些别的东西..例如广告', textScaleFactor: 1.5, style: TextStyle(color: Colors.red))
                  ],
                ),
                Divider(height: 2.0, color: Colors.black54),
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
              alignment: Alignment.center)),
      // SliverFixedExtentList 实现同 List.custom 实现类似
      SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
                  (_, index) => InkWell(
                child: Container(
                  child: Text("ABCD",
                      style: TextStyle(color: Colors.black, letterSpacing: 2.0),
                      textScaleFactor: 1.5),
                  alignment: Alignment.center,
                ),
                onTap: () {},
              ),
              childCount: 20),
          itemExtent: 60.0)
    ]),
    bottomSheet: Container(
      child: Row(
        children: <Widget>[
          Expanded(child: CompatTextField()),
          CompatButton(
            child: Text('发送'),
            onPressed: () {},
          ),
        ],
      ),
    ),
    floatingActionButton: Builder(builder: (c) {
      return FloatingActionButton(
        onPressed: () {
          Scaffold.of(c).showBottomSheet(
            (c) {
              return Container(
                child: Text("我是底部弹出来的"),
                height: 200.0,
              );
            },
          );
        },
      );
    }),
);