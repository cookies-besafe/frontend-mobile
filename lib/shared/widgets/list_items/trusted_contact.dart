import 'package:besafe/api_service.dart';
import 'package:besafe/models.dart';
import 'package:besafe/shared/styles.dart';
import 'package:flutter/material.dart';
import '../modals/yes_no_dialog.dart';
import 'styles.dart';

class _Badge extends StatelessWidget {
  const _Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryBgColor,
        border: Border.all(width: 1, color: primaryBorderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        'assets/images/user-icon.png',
        width: 16,
        height: 16,
      ),
    );
  }
}

class TrustedContactItem extends StatelessWidget {
  final TrustedContactModel trustedContact;
  final BuildContext context;

  const TrustedContactItem(
      {required this.context, required this.trustedContact, Key? key})
      : super(key: key);

  Widget _getActionButton(VoidCallback onPressed, String assetName) =>
      SizedBox(
        width: 32,
        height: 32,
        child: TextButton(
            onPressed: onPressed,
            child: Image.asset('assets/images/$assetName',
                width: 14, height: 14)),
      );

  Future<dynamic> promptDelete() async =>
      showDialog(
          context: context,
          builder: (context) =>
          const YesNoDialog(
            title: 'Delete contact',
            description: 'Are you sure want to delete this trusted contact?',
            noText: 'Cancel',
            yesText: 'Delete',
          )).then((value) => {
            if(value) {
              TrustedContactApi.delete(trustedContact),
              Navigator.popAndPushNamed(context, '/trustedContact/list')
            }
      });

  void editTrustedContact() {
    Navigator.pushNamed(
      context,
      '/trustedContact/edit',
      arguments: {'trustedContact': trustedContact},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          const _Badge(),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
          Text(trustedContact.name, style: trustedContactNameStyle),
          const Spacer(),
          _getActionButton(promptDelete, 'trash-can.png'),
          _getActionButton(editTrustedContact, 'pencil-icon.png'),
        ],
      ),
    );
  }
}
