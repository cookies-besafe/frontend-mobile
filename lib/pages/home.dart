import 'package:besafe/shared/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BeSafeAppBar(
            titleText: 'BeSafe.', titleType: TitleType.primary),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              SosSignal(),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Spacer(),
              CallBlock(name: 'Ministry of Internal Affairs', phone: '1259'),
              CallBlock(name: 'Women\'s Helpline', phone: '1146'),
            ],
          ),
        ),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ));
  }
}
