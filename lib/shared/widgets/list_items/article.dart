import 'package:besafe/models.dart';
import 'package:besafe/shared/widgets/list_items/styles.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final ArticleModel article;

  const ArticleItem({required this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(article.title, style: articleHeaderStyle,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,)),
              SizedBox(
                  height: 24,
                  child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/articles/detail', arguments: {'article': article}),
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 14)),
                      child: const Text('Read more', style: articleLinkStyle))),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(article.content, maxLines: 3, overflow: TextOverflow.ellipsis, style: articleContentStyle),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(article.pubDate(), style: articlePubDateStyle),
        ],
      ),
    );
  }
}
