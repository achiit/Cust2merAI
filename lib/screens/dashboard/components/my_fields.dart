import 'dart:async';
import 'package:admin/constants.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'file_info_card.dart'; // Import the file where FileInfoCard is defined
import 'package:admin/viewmodel/status_count_provider.dart'; // Import the file where StatusService is defined

class MyFiles extends StatefulWidget {
  const MyFiles({Key? key}) : super(key: key);

  @override
  _MyFilesState createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  late StreamSubscription<Map<String, int>> _statusSubscription;
  int solvedCount = 0;
  int unsolvedCount = 0;

  @override
  void initState() {
    super.initState();

    // Subscribe to the stream
    _statusSubscription = StatusService.priorityStream.listen((data) {
      setState(() {
        // Update your local variables with the latest counts
        solvedCount = data['solvedCount'] ?? 0;
        unsolvedCount = data['unsolvedCount'] ?? 0;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _statusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Complaints Resolve",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: 1.1,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          FileInfoCardWidget(index: 0),
          FileInfoCardWidget(index: 1),
        ],
      ),
      tablet: Row(
        children: [
          FileInfoCardWidget(index: 0),
          FileInfoCardWidget(index: 1),
        ],
      ),
      desktop: Row(
        children: [
          FileInfoCardWidget(index: 0),
          FileInfoCardWidget(index: 1),
        ],
      ),
    );
  }
}

class FileInfoCardWidget extends StatelessWidget {
  final int index;

  FileInfoCardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)), // Add a delay of 1 second
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // You can show a loading indicator during the delay
          } else {
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: demoMyFiles[index].color!.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${demoMyFiles[index].title}: ${demoMyFiles[index].solvedCount}",
                  ),
                  Container(
                    width: 200,
                    child: ProgressLine(
                      color: demoMyFiles[index].color,
                      percentage: index == 0
                          ? demoMyFiles[index].solvedpercentage
                          : demoMyFiles[0].unsolvedpercentage,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  List demoMyFiles = [
    CloudStorageInfo(
      title: "Solved",
      svgSrc: "assets/icons/Documents.svg",
      color: primaryColor,
      solvedCount: StatusService.solvedCount,
      unsolvedCount: StatusService.unsolvedCount,
    ),
    CloudStorageInfo(
      title: "Unsolved",
      svgSrc: "assets/icons/google_drive.svg",
      color: Color(0xFFFFA113),
      solvedCount: StatusService.unsolvedCount,
      unsolvedCount: StatusService.unsolvedCount,
    ),
  ];
}
