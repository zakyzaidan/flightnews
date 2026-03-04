import 'package:flightnews/feature/home/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text("Error: ${provider.error}"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Text("Artikel Space Flight News"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final article = provider.articles?.results[index];
                    return ListTile(
                      title: Text(article?.title ?? "No Title"),
                      subtitle: Text(article?.authors[0].name ?? "No Author"),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
