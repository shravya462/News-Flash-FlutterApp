import 'package:flutter/material.dart';
import 'package:flutter_project/components/newscard.dart';
import 'package:flutter_project/components/no_network.dart';
import 'package:flutter_project/components/text_widget.dart';
import 'package:flutter_project/l10n/app_localization.dart';
import 'package:flutter_project/news_article.dart';
import 'package:flutter_project/news_service.dart';
import 'package:flutter_project/settings_screen.dart';
import 'package:flutter_project/utils/network_util.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<Articles> newsListData = [];
  String errorMessage = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    newsApi();
  }

//api call to fetch news data list
  Future<void> newsApi() async {
    try {
      final response = await ApiService().getNewsData();
      setState(() {
        newsListData = response.articles ?? [];
        isLoading = false;
      });
    } catch (e) {
      // Handle the error by displaying a message or taking other actions
      print("Error fetching news data: $e");
      // You can set an error message to display in the UI if needed
      setState(() {
        isLoading = false;
        errorMessage = AppLocalizations.of(context)?.translate("error") ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    //checks the network connection of the device
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(body: NoNetwork())
        : Scaffold(
            appBar: AppBar(
              title: TextWidget(
                txtTitle:
                    AppLocalizations.of(context)?.translate("newsTitle") ?? "",
                txtFontStyle: FontWeight.w400,
                txtFontSize: 23,
              ),
              elevation: 50.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != ""
                    ? Center(
                        child: TextWidget(
                          txtTitle: errorMessage,
                          txtFontStyle: FontWeight.w400,
                          txtFontSize: 23,
                        ),
                      )
                    : newsListData.isNotEmpty
                        ? ListView.builder(
                            itemCount: newsListData.length,
                            itemBuilder: (context, index) {
                              return NewsCard(
                                title: newsListData[index].title ?? "",
                                imageUrl: newsListData[index].urlToImage ?? "",
                              );
                            },
                          )
                        : Center(
                            child: TextWidget(
                              txtTitle: AppLocalizations.of(context)
                                      ?.translate("noDataFound") ??
                                  "",
                              txtFontStyle: FontWeight.w400,
                              txtFontSize: 23,
                            ),
                          ),
          );
  }
}
