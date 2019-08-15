import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/page/page_routes.dart';

class GridPageContent {
  const GridPageContent(this.routeName, this.icon);

  final String routeName;
  final IconData icon;
}

class MainGridIndex {
  static final int pageContent = 0;
}

final List<GridPageContent> mainGridPage = [
  GridPageContent(PageRoutes.pageContent, Icons.access_alarms),
  GridPageContent(PageRoutes.pageContent, Icons.access_time),
  GridPageContent(PageRoutes.pageContent, Icons.settings),
  GridPageContent(PageRoutes.pageContent, Icons.language),
  GridPageContent(PageRoutes.pageContent, Icons.arrow_right),
  GridPageContent(PageRoutes.pageContent, Icons.apps),
  GridPageContent(PageRoutes.pageContent, Icons.archive),
];