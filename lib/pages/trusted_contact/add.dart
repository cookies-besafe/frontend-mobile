import 'package:flutter/material.dart';

import 'mixins.dart';

class TrustedContactAdd extends StatefulWidget {
  const TrustedContactAdd({Key? key}) : super(key: key);

  @override
  State<TrustedContactAdd> createState() => TrustedContactAddState();
}

class TrustedContactAddState extends State<TrustedContactAdd> with AddEditTrustedPeopleMixin {
  @override
  int? get id => null;

  @override
  String get actionButtonText => 'Add';
}
