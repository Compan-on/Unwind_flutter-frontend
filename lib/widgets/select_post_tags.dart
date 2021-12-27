import "package:flutter/material.dart";
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SelectPostTags extends StatefulWidget {
  const SelectPostTags({Key? key}) : super(key: key);

  @override
  _SelectPostTagsState createState() => _SelectPostTagsState();
}

class _SelectPostTagsState extends State<SelectPostTags> {
  //temp
  static List _mentalProblems =
      new List.generate(20, (i) => "Problem " + (i + 1).toString());

  final _items = _mentalProblems.map((e) => MultiSelectItem(e, e)).toList();
  List _selectedMentalProblems = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MultiSelectBottomSheetField(
            buttonIcon: Icon(Icons.segment),
            initialChildSize: 0.4,
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text("Select Tags"),
            title: Text("Select Tags"),
            items: _items,
            onConfirm: (values) {
              setState(() {
                _selectedMentalProblems = values as List;
              });
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                setState(() {
                  _selectedMentalProblems.remove(value);
                });
              },
            ),
          ),
          _selectedMentalProblems == null || _selectedMentalProblems.isEmpty
              ? Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected",
                    style: TextStyle(color: Colors.black54),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
