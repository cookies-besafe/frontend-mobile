import 'dart:io';

import 'package:besafe/models.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'styles.dart';

class _DateTimeInfo extends StatelessWidget {
  final DateTime dateTime;

  const _DateTimeInfo({required this.dateTime, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Text(DateFormat.MMMMd().format(dateTime), style: importantTextStyle),
          const Spacer(),
          Text(DateFormat.jm().format(dateTime), style: hintTextStyle)
        ],
      ),
    );
  }
}

class SosRequestItem extends StatefulWidget {
  final Future<ListResult> futureFiles;
  final SosRequestModel sosRequestModel;
  final BuildContext context;

  const SosRequestItem(
      {required this.context,
      required this.futureFiles,
      required this.sosRequestModel,
      Key? key})
      : super(key: key);

  @override
  State<SosRequestItem> createState() => _SosRequestItemState();
}

class _SosRequestItemState extends State<SosRequestItem> {
  Future downloadFile(Reference ref) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final url = await ref.getDownloadURL();
    await Dio().download(url, '/storage/emulated/0/Download/${ref.name}');

    if (mounted) {
      ScaffoldMessenger.of(widget.context).showSnackBar(
          SnackBar(content: Text('Downloaded ${ref.name} Downloads folder')));
    }
  }

  Widget drawSingleFile(Reference? ref) {
    if (ref == null) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'No file available',
                    style: importantTextStyle,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.basename(ref.name),
                style: importantTextStyle,
              ),
              Text(
                '${p.extension(ref.name)} - Audio',
                style: hintTextStyle,
              )
            ],
          ),
          const Spacer(),
          PrimaryButton(text: 'Download', onPressed: () => downloadFile(ref)),
        ],
      ),
    );
  }

  Widget drawResult(ListResult listResult) {
    final Reference? ref = listResult.items.firstWhereOrNull(
        (element) => element.name == 'audio-${widget.sosRequestModel.id}.aac');

    return Column(
      children: [
        _DateTimeInfo(dateTime: widget.sosRequestModel.createdAt),
        drawSingleFile(ref),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
      future: widget.futureFiles,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          throw 'futureFiles: Data returned is null ';
        }
        ListResult data = snapshot.data as ListResult;
        return drawResult(data);
      },
    );
  }
}
