import 'package:besafe/api_service.dart';
import 'package:besafe/models.dart';
import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SosRequestHistory extends StatefulWidget {
  const SosRequestHistory({Key? key}) : super(key: key);

  @override
  State<SosRequestHistory> createState() => _SosRequestHistoryState();
}

class _SosRequestHistoryState extends State<SosRequestHistory> {
  late Future<List<SosRequestModel>> _sosRequestsListFuture;

  @override
  void initState() {
    _sosRequestsListFuture = SosRequestApi.list();
    super.initState();
  }

  Widget getSosRequestsList() {
    Widget drawResult(List<SosRequestModel> data) {
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
      late Future<ListResult> futureFiles = FirebaseStorage.instance
          .ref('/files/${data[0].userId}')
          .listAll();

      return ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) => SosRequestItem(
            context: context,
            futureFiles: futureFiles,
            sosRequestModel: data[index],
          ),
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: dividerColor,
          thickness: 1,
        ),
      );
    }

    FutureBuilder builder = FutureBuilder<List<SosRequestModel>>(
        future: _sosRequestsListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            throw 'getSosRequestsList(): Data returned is null ';
          }
          List<SosRequestModel> data = snapshot.data as List<SosRequestModel>;
          return drawResult(data);
        });

    return builder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BeSafeAppBar(
            titleText: 'History', titleType: TitleType.secondary),
        body: Container(
          color: Colors.white,
          child: getSosRequestsList(),
        ),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ));
  }
}
