import 'package:besafe/models.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:besafe/shared/widgets/list_items/styles.dart';
import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key}) : super(key: key);

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  ArticleModel? article;

  Widget getContents() => Container(
    color: Colors.white,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article!.pubDate(), style: articlePubDateStyle),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(article!.title, style: articleHeaderStyle),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
          Text(article!.content, style: articleContentStyle),
        ]),
  );

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    article = arguments['article'];

    return Scaffold(
        appBar: const BeSafeAppBar(
            titleText: 'Articles',
            titleType: TitleType.secondary,
            backButton: true),
        body: getContents(),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ));
  }
}
