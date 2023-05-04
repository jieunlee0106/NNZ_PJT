import 'package:flutter/material.dart';
import 'package:nnz/src/pages/category/concert.dart';
import 'package:nnz/src/pages/category/musical.dart';
import 'package:nnz/src/pages/category/stage.dart';
import 'package:nnz/src/pages/category/movie.dart';
import 'package:nnz/src/pages/category/sports.dart';
import 'package:nnz/src/pages/category/esports.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> items;
  final String cartegory;

  const CategoryDropdown({
    super.key,
    required this.items,
    required this.cartegory,
  });

  @override
  _MusicalDropdownState createState() => _MusicalDropdownState();
}

class _MusicalDropdownState extends State<CategoryDropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(widget.cartegory),
      value: dropdownValue,
      icon: const Icon(Icons.expand_more),
      iconSize: 24,
      elevation: 16,
      underline: Container(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });

        // 페이지 이동
        if (dropdownValue == widget.items[0]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConcertPage()),
          );
        } else if (dropdownValue == widget.items[1]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MusicalPage()),
          );
        } else if (dropdownValue == widget.items[2]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StagePage()),
          );
        } else if (dropdownValue == widget.items[3]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoviePage()),
          );
        } else if (dropdownValue == widget.items[4]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SportsPage()),
          );
        } else if (dropdownValue == widget.items[5]) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ESportsPage()),
          );
        }
      },
      items: <String>['콘서트', '뮤지컬', '연극', '페스티벌', '스포츠', 'e스포츠']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
