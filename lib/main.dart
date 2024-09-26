import 'package:flutter/material.dart';
import 'package:myapp/orang.dart';

void main() => runApp(const DataTableExampleApp());

class DataTableExampleApp extends StatelessWidget {
  const DataTableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DataTable Nama'),
          backgroundColor: const Color.fromARGB(255, 205, 243, 33),
        ),
        body: const DataTableExample(),
      ),
    );
  }
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  // static const int numItems = 20;
  // List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  int sortIndex = 0;
  bool isAscending = true;

  List<Orang> orang = [
    Orang(nama: 'Praditya', alamat: 'Wonosobo', umur: 21),
    Orang(nama: 'raditya', alamat: 'sobo', umur: 12),
    Orang(nama: 'aditya', alamat: 'onosobo', umur: 16),
  ];
  List<Orang> selectedOrang = [];

  sortData() {
    if (sortIndex == 0) {
      orang.sort((a, b) {
        if (isAscending) {
          return a.nama
              .toString()
              .toLowerCase()
              .compareTo(b.nama.toString().toLowerCase());
        } else {
          return b.nama
              .toString()
              .toLowerCase()
              .compareTo(a.nama.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 1) {
      orang.sort((a, b) {
        if (isAscending) {
          return a.alamat
              .toString()
              .toLowerCase()
              .compareTo(b.alamat.toString().toLowerCase());
        } else {
          return b.alamat
              .toString()
              .toLowerCase()
              .compareTo(a.alamat.toString().toLowerCase());
        }
      });
    } else {
      orang.sort((a, b) {
        if (isAscending) {
          return a.umur
              .toString()
              .toLowerCase()
              .compareTo(b.umur.toString().toLowerCase());
        } else {
          return b.umur
              .toString()
              .toLowerCase()
              .compareTo(a.umur.toString().toLowerCase());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: DataTable(
      sortColumnIndex: sortIndex,
      sortAscending: isAscending,
      columns: [
        DataColumn(
          onSort: (columnIndex, ascending) {
            sortIndex = columnIndex;
            isAscending = ascending;
            setState(() {});
            sortData();
          },
          label: const Text('Nama'),
        ),
        DataColumn(
            onSort: (columnIndex, ascending) {
              sortIndex = columnIndex;
              isAscending = ascending;
              setState(() {});
              sortData();
            },
            label: const Text('Alamat')),
        DataColumn(
            onSort: (columnIndex, ascending) {
              sortIndex = columnIndex;
              isAscending = ascending;
              setState(() {});
              sortData();
            },
            label: const Text('Umur')),
      ],
      rows: orang
          .map((orang) => DataRow(
                selected: selectedOrang.contains(orang),
                onSelectChanged: (isSelected) => setState(() {
                  final isAdding = isSelected != null && isSelected;

                  isAdding ? selectedOrang.add(orang): selectedOrang.remove(orang);
                }),
                cells: [
                  DataCell(Text(orang.nama ?? '')),
                  DataCell(Text(orang.alamat ?? '')),
                  DataCell(Text(orang.umur.toString())),
                ],
              ))
          .toList(),
    ));
  }
}
