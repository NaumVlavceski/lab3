import 'package:flutter/material.dart';
import 'package:lab3/services/ApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/Recipe.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService _apiService = ApiService();

  late Recipe meal;
  late Recipe _detail;
  bool _loading = true;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      meal = ModalRoute.of(context)!.settings.arguments as Recipe;
      _detailMeal();
      _initialized = true;
    }
  }

  Future<void> _detailMeal() async {
    final detail = await _apiService.detailMeal(meal.id);
    setState(() {
      _detail = detail!;
      _loading = false;
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Не може да се отвори линкот");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(centerTitle:true,title: Text(_detail.name)),
            body: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(_detail.img),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(_detail.name, style: TextStyle(fontSize: 30)),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        height: 80,
                        child: SingleChildScrollView(child: Text(_detail.desc)),
                      ),
                    ),
                    Divider(),
                    for (var i = 0; i < _detail.ingredients.length / 2; i++)
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${i + 1}. ${_detail.ingredients[i]}"),
                            if (_detail.ingredients.length % 2 != 0)
                              if (i + (_detail.ingredients.length / 2).ceil() <
                                  _detail.ingredients.length)
                                Text(
                                  "${i + (_detail.ingredients.length / 2 + 1).ceil()}. ${_detail.ingredients[i + (_detail.ingredients.length / 2).ceil()]}",
                                ),
                            if (_detail.ingredients.length % 2 == 0)
                              Text(
                                "${i + (_detail.ingredients.length / 2 + 1).toInt()}. ${_detail.ingredients[i + (_detail.ingredients.length / 2).toInt()]}",
                              ),
                          ],
                        ),
                      ),

                    Divider(),
                    GestureDetector(
                      onTap: () => _openUrl(_detail.youTube),
                      child: Text(
                        "Watch on YouTube",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
  }
}
