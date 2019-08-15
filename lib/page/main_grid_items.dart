import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/page/page_routes.dart';

class GridPageContent {
  const GridPageContent(this.routeName, this.title, this.materialIcon, [IconData cupertinoIcon])
      : cupertinoIcon = cupertinoIcon ?? materialIcon;

  final String routeName;
  final String title;
  final IconData materialIcon;
  final IconData cupertinoIcon;
}

class MainGridIndex {
  static final int pageContent = 0;
}

final List<GridPageContent> mainGridPage = [
  GridPageContent(PageRoutes.pageContent, "Quran", Icons.book, CupertinoIcons.book_solid),
  GridPageContent(PageRoutes.pageContent, "Prayer", Icons.accessibility, CupertinoIcons.person_solid),
  GridPageContent(PageRoutes.pageContent, "Qibla", Icons.public),
  GridPageContent(PageRoutes.pageContent, "NearBy", Icons.place, CupertinoIcons.location_solid),
  GridPageContent(PageRoutes.pageContent, "FM", Icons.radio, CupertinoIcons.news_solid),
  GridPageContent(PageRoutes.pageContent, "Wallpaper", Icons.photo_library),
  GridPageContent(PageRoutes.pageContent, "Names", Icons.portrait, CupertinoIcons.group_solid),
  GridPageContent(PageRoutes.pageContent, "Calendar", Icons.calendar_today),
  GridPageContent(PageRoutes.pageContent, "Greeting Cards", Icons.photo),
  GridPageContent(null, "to be continued...", Icons.apps),
];