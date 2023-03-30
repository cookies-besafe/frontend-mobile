import 'package:besafe/api_service.dart';
import 'package:besafe/models.dart';
import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:flutter/material.dart';

class TrustedContactList extends StatefulWidget {
  const TrustedContactList({Key? key}) : super(key: key);

  @override
  State<TrustedContactList> createState() => _TrustedContactListState();
}

class _TrustedContactListState extends State<TrustedContactList> {
  late Future<List<TrustedContactModel>> _trustedContactsListFuture;

  @override
  void initState() {
    _trustedContactsListFuture = TrustedContactApi.list();
    super.initState();
  }

  Widget getTrustedPeopleList() {
    Widget drawResult(List<TrustedContactModel> data) {
      if (data.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topCenter,
          child: const Text(
            'Nothing here yet',
            style:
                TextStyle(color: secondaryTextColor, fontFamily: 'SF-Pro-Text'),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 70),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return TrustedContactItem(
              context: context, trustedContact: data[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: dividerColor,
          thickness: 1,
        ),
      );
    }

    FutureBuilder builder = FutureBuilder<List<TrustedContactModel>>(
        future: _trustedContactsListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            throw 'getTrustedPeopleList(): Data returned is null ';
          }
          List<TrustedContactModel> data =
              snapshot.data as List<TrustedContactModel>;
          return drawResult(data);
        });

    return builder;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BeSafeAppBar(
            titleText: 'Trusted people', titleType: TitleType.secondary),
        body: Container(
          color: Colors.white,
          child: getTrustedPeopleList(),
        ),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ),
        floatingActionButton: PrimaryButton(
            text: '+ Add people',
            onPressed: () =>
                Navigator.pushNamed(context, '/trustedContact/add')));
}
