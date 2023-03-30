import 'package:besafe/api_service.dart';
import 'package:besafe/models.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'utils.dart';

class MenuDrawer extends StatefulWidget {
  final BuildContext context;

  const MenuDrawer({required this.context, Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late final Future<UserModel> me;

  @override
  void initState() {
    me = UserApi.getMe();

    super.initState();
  }

  Widget _getMenuBody() => Column(
        children: [
          MenuItem(
              iconName: 'info.png',
              text: 'SOS',
              onTap: () =>
                  Navigator.popUntil(widget.context, (route) => route.isFirst)),
          const MenuSubheading(text: 'General'),
          MenuItem(
              iconName: 'shield-people.png',
              text: 'Trusted people',
              onTap: () =>
                  Navigator.pushNamed(widget.context, '/trustedContact/list')),
          MenuItem(
              iconName: 'hand-heart.png',
              text: 'Rehabilitation centers',
              onTap: () {}),
          MenuItem(iconName: 'discuss.png', text: 'Forum', onTap: () {}),
          const MenuSubheading(text: 'Plugins'),
          MenuItem(iconName: 'feather.png', text: 'Support', onTap: () {}),
          MenuItem(
              iconName: 'puzzle.png',
              text: 'Articles',
              onTap: () => Navigator.pushNamed(context, '/articles/list')),
          MenuItem(
              iconName: 'clock.png',
              text: 'History',
              onTap: () =>
                  Navigator.pushNamed(context, '/sosRequests/history')),
          MenuItem(iconName: 'gear.png', text: 'Settings', onTap: () {}),
        ],
      );

  @override
  Widget build(BuildContext context) => Drawer(
      elevation: 0,
      child: Column(children: [
        getProfile(me),
        const Divider(color: Color.fromRGBO(234, 234, 239, 1), thickness: 1),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: _getMenuBody(),
        ),
        const Spacer(),
        const Divider(color: Color.fromRGBO(234, 234, 239, 1), thickness: 1),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Material(
            child: MenuItem(
              iconName: 'exit.png',
              text: 'Log out',
              onTap: () {
                UserApi.logout().then(
                    (value) => Navigator.popAndPushNamed(context, '/login'));
              },
            ),
          ),
        )
      ]));
}
