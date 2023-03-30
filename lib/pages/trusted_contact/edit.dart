import 'package:besafe/models.dart';
import 'package:flutter/material.dart';

import 'mixins.dart';

class TrustedContactEdit extends StatefulWidget {
  const TrustedContactEdit({Key? key}) : super(key: key);

  @override
  State<TrustedContactEdit> createState() => _TrustedContactEditState();
}

class _TrustedContactEditState extends State<TrustedContactEdit>
    with AddEditTrustedPeopleMixin {
  late final TrustedContactModel trustedContact;

  @override
  int? get id => trustedContact.id;

  @override
  String get actionButtonText => 'Save';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    trustedContact = arguments['trustedContact'];
    _populateControllers();

    return super.build(context);
  }

  void _populateControllers() {
    nameController.text = trustedContact.name;
    phoneController.text = trustedContact.phone;
    emailController.text = trustedContact.email;
    telegramNicknameController.text = trustedContact.telegramNickname;
  }
}
