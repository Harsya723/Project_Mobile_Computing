import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class RefPreviewScreen extends StatefulWidget {
  final Map<String, dynamic> refDiary;
  const RefPreviewScreen({super.key, required this.refDiary});

  @override
  State<RefPreviewScreen> createState() => _RefPreviewScreenState();
}

class _RefPreviewScreenState extends State<RefPreviewScreen> {
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    print(widget.refDiary);
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
                Image.asset(
                  widget.refDiary['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.refDiary['title'],
                  style: TextStyle(
                    color: colours.dark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: fonts.semibold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.refDiary['date'],
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.regular,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.refDiary['content'],
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
