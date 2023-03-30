import 'package:besafe/models.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

Widget getProfile(Future<UserModel> me) {
  Widget drawProfile(String firstName, String lastName, String phone) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$firstName $lastName', style: profileNameStyle),
          Text(phone, style: profilePhoneStyle)
        ],
      );

  FutureBuilder builder = FutureBuilder<UserModel>(
      future: me,
      builder: (context, snapshot) {
        String firstName, lastName, phone;

        try {
          UserModel user = snapshot.requireData;
          firstName = user.firstName;
          lastName = user.lastName;
          phone = user.phone;
        } on StateError {
          firstName = '...';
          lastName = '...';
          phone = '...';
        } catch (e) {
          firstName = 'Error';
          lastName = 'Error';
          phone = 'Error';
        }

        return drawProfile(firstName, lastName, phone);
      });

  return Container(
    margin: const EdgeInsets.only(top: 40),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    alignment: Alignment.centerLeft,
    child: builder,
  );
}
