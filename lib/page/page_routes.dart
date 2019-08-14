import 'package:flutter/widgets.dart';

import 'content_page.dart';

class PageRoutes {
  static final String pageContent = "content";
}

final Map<String, WidgetBuilder> globalPageRoutes = <String, WidgetBuilder>{
  PageRoutes.pageContent: (context) => ContentPage(),
};