import 'package:besafe/api_service.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:flutter/material.dart';

import 'package:besafe/models.dart';

mixin AddEditTrustedPeopleMixin<T extends StatefulWidget> on State<T> {
  int? get id;
  String get actionButtonText;

  final TextEditingController nameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      telegramNicknameController = TextEditingController();

  TrustedContactModel gatherValues() {
    TrustedContactModel trustedContact = TrustedContactModel(
        id: id,
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        telegramNickname: telegramNicknameController.text);

    return trustedContact;
  }

  Future<void> _sendRequest(TrustedContactModel trustedContact) {
    if (trustedContact.id == null) {
      return TrustedContactApi.create(trustedContact);
    } else {
      return TrustedContactApi.update(trustedContact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BeSafeAppBar(
            titleText: 'Trusted people', titleType: TitleType.secondary),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputEntry(
                  text: 'Name',
                  widget: FormattedTextField(
                      text: 'Name', controller: nameController)),
              InputEntry(
                  text: 'Phone',
                  widget: FormattedTextField(
                      text: '+998 ()', controller: phoneController)),
              InputEntry(
                  text: 'Email',
                  widget: FormattedTextField(
                      text: 'example@gmail.com', controller: emailController)),
              InputEntry(
                  text: 'Telegram username',
                  widget: FormattedTextField(
                      text: '@example',
                      controller: telegramNicknameController)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              PrimaryButton(
                  text: actionButtonText,
                  onPressed: () {
                    TrustedContactModel trustedContact = gatherValues();
                    _sendRequest(trustedContact).then((value) =>
                        Navigator.pushNamed(context, '/trustedContact/list'));
                  }),
            ],
          ),
        ),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ));
  }
}
