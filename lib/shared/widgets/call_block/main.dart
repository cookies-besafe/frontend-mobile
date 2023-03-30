import 'package:besafe/shared/utils.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

class _CallButton extends StatelessWidget {
  final String phone;

  const _CallButton({required this.phone});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 32,
        height: 32,
        child: RawMaterialButton(
          onPressed: () => callPhone(phone),
          shape: const CircleBorder(),
          fillColor: const Color.fromRGBO(245, 192, 184, 1),
          elevation: 0,
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            'assets/images/phone-icon.png',
            width: 20,
            height: 20,
          ),
        ));
  }
}

class CallBlock extends StatelessWidget {
  final String name, phone;

  const CallBlock({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: callBoxDecoration,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: callNameTextStyle),
              Text(phone, style: callPhoneTextStyle)
            ],
          ),
          const Spacer(),
          _CallButton(phone: phone),
        ],
      ),
    );
  }
}