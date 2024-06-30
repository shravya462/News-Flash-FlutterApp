import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/text_widget.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const NewsCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
              txtTitle: title,
              txtFontStyle: FontWeight.bold,
              txtFontSize: 16,
              wrapValue: true,
            ),
          ),
        ],
      ),
    );
  }
}
