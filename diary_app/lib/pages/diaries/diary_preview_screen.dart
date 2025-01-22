import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/date_format.dart';
import 'package:diary_app/utils/endpoints.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class DiaryPreviewScreen extends StatefulWidget {
  final dynamic diary;
  const DiaryPreviewScreen({super.key, this.diary});

  @override
  State<DiaryPreviewScreen> createState() => _DiaryPreviewScreenState();
}

class _DiaryPreviewScreenState extends State<DiaryPreviewScreen> {
  final Endpoints endpoints = Endpoints();
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    print(widget.diary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preview Diary',
          style: TextStyle(
            color: colours.dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: fonts.semibold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              (widget.diary['attachment'] == null || widget.diary['attachment'] == '') ? Center(
                child: Text(
                  'No Image',
                  style: TextStyle(
                    color: colours.dark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: fonts.semibold,
                  ),
                ),
              ) : Image.network(
                '${endpoints.storageUrl}/${widget.diary!['attachment']}',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                widget.diary['title'],
                style: TextStyle(
                  color: colours.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: fonts.semibold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                CustomDateFormat.formatWithDay(DateTime.parse(widget.diary['date'])),
                style: TextStyle(
                  color: colours.grey,
                  fontSize: 16,
                  fontFamily: fonts.regular,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.diary['content'],
                style: TextStyle(
                  color: colours.dark,
                  fontSize: 16,
                  fontFamily: fonts.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
