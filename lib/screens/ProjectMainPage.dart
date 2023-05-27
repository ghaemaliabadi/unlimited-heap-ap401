import 'package:flutter/material.dart';

class ProjectMainPage extends StatefulWidget {
  const ProjectMainPage({super.key});

  final String title = 'صفحه اصلی پروژه';

  @override
  State<ProjectMainPage> createState() => _ProjectMainPage();
}

class _ProjectMainPage extends State<ProjectMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title, style: Theme.of(context).textTheme.headline2),
        // remove app bar background color
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        // decrease top bar height
        toolbarHeight: 2.0,
        // elevation: 2.0,
        centerTitle: true,
        titleSpacing: 0.0,
        // add back icon without leading space
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // row for back icon
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                // move to right side
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  // back to previous page
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
