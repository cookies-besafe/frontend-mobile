import 'package:besafe/api_service.dart';
import 'package:besafe/models.dart';
import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:flutter/material.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  late Future<List<ArticleModel>> _futureArticles;

  @override
  void initState() {
    _futureArticles = ArticleApi.list();
    super.initState();
  }

  Widget getArticles() {
    Widget drawResult(List<ArticleModel> data) {
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

      return Expanded(child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 40),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ArticleItem(article: data[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: dividerColor,
          thickness: 1,
        ),
      ));
    }

    FutureBuilder builder = FutureBuilder<List<ArticleModel>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            throw 'getArticles(): Data returned is null ';
          }
          List<ArticleModel> data = snapshot.data as List<ArticleModel>;
          return drawResult(data);
        });

    return builder;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BeSafeAppBar(
            titleText: 'Articles', titleType: TitleType.secondary),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
              SearchBar(onInput: () {}),
              const Divider(color: dividerColor, thickness: 1,),
              getArticles(),
            ],
          ),
        ),
        endDrawer: SizedBox(
          width: 270,
          child: MenuDrawer(context: context),
        ));
}
