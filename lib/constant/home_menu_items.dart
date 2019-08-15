class MenuItem {
  const MenuItem(this.menuKey, this.title);

  final int menuKey;
  final String title;
}

class HomeMenuKey {
  static final int menuUpgrade = 0;
  static final int menuSettings = 1;
  static final int menuAbout = 2;

  static final int menuCancel = 3;
}

final MenuItem cancelMenu = MenuItem(HomeMenuKey.menuCancel, "Cancel");

final List<MenuItem> homeMenuList = [
  MenuItem(HomeMenuKey.menuUpgrade, "Upgrade"),
  MenuItem(HomeMenuKey.menuSettings, "Settings"),
  MenuItem(HomeMenuKey.menuAbout, "About"),
];