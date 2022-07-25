import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<List<dynamic>>? csvData;

  Future<List<List<dynamic>>> processCsv() async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "assets/ปิดอ่าวตัวก_310560.csv",
    );
    return const CsvToListConverter().convert(result, eol: "\n");
  }

  @override
  Widget build(BuildContext context) {
    csvData == null
        ? null
        : csvData!.map((e) {
            print(e[4]);
          }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Csv reader"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: csvData == null
            ? Center(child: const CircularProgressIndicator())
            : Column(
                children: [
                  // DataTable(
                  //   columns: csvData![0]
                  //       .map(
                  //         (item) => DataColumn(
                  //           label: Text(
                  //             item.toString(),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  //   rows: csvData!
                  //       .map(
                  //         (csvrow) => DataRow(
                  //           cells: csvrow
                  //               .map(
                  //                 (csvItem) => DataCell(
                  //                   Text(
                  //                     csvItem.toString(),
                  //                   ),
                  //                 ),
                  //               )
                  //               .toList(),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  Text(csvData![1][4]),
                  Text(csvData!.length.toString()),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          csvData = await processCsv();
          // print(csvData![2][4]);
          setState(() {});
        },
      ),
    );
  }
}
