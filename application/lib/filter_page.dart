import 'package:flutter/material.dart';

typedef void Callback(List<String> value, bool finished);

class FilterPage extends StatefulWidget {
  final List<String> allTags;
  final Callback callback;
  const FilterPage(this.allTags, {super.key, required this.callback});
  @override
  State<FilterPage> createState() => _FilterPage();
}

class _FilterPage extends State<FilterPage> {
  List<bool> _isChecked = [];
  List<String> finalTags = [];

  @override
  void initState() {
    super.initState();
    _isChecked =
        List<bool>.filled(widget.allTags.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "필터링",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Container(
                height: 400,
                width: 300,
                child: ListView.builder(
                    itemCount: widget.allTags.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: CheckboxListTile(
                        title: Text(widget.allTags[index]),
                        value: _isChecked[index],
                        onChanged: (value) {
                          setState(() {
                            _isChecked[index] = value!;
                            if (_isChecked[index] == true) {
                              finalTags.add(widget.allTags[index]);
                            } else {
                              finalTags.remove(widget.allTags[index]);
                            }
                          });
                        },
                      ));
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    child: Text("초기화하기",
                        style: Theme.of(context).textTheme.titleMedium),
                    onPressed: () {
                      setState(() {
                        _isChecked.clear();
                        finalTags.clear();
                        _isChecked = List.filled(widget.allTags.length, false,
                            growable: true);
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    child: Text("필터링",
                        style: Theme.of(context).textTheme.titleMedium),
                    onPressed: () {
                      widget.callback(finalTags, true);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ));
  }
}
