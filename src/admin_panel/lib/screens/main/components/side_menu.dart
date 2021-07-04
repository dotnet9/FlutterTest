import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      // it enables scrolling
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          DrawerListTitle(
            title: '面板',
            svgSrc: 'assets/icons/menu_dashboard.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '交易',
            svgSrc: 'assets/icons/menu_tran.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '任务',
            svgSrc: 'assets/icons/menu_task.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '文档',
            svgSrc: 'assets/icons/menu_doc.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '店铺',
            svgSrc: 'assets/icons/menu_store.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '通知',
            svgSrc: 'assets/icons/menu_notification.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '个人简介',
            svgSrc: 'assets/icons/menu_profile.svg',
            press: () {},
          ),
          DrawerListTitle(
            title: '设置',
            svgSrc: 'assets/icons/menu_setting.svg',
            press: () {},
          ),
        ],
      ),
    ));
  }
}

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle(
      {Key? key,
      // For selecting those three line once press 'Command + D'
      required this.title,
      required this.svgSrc,
      required this.press})
      : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
