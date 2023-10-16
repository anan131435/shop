import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var leftWidth = MediaQuery.of(context).size.width / 4;
    var rightItemWidth = (MediaQuery.of(context).size.width - leftWidth - 40) / 4;
    return Row(
      children: [
        Container(
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 28,
                        color: (_selectedIndex == index) ? Colors.red : Colors.white,
                        child: Text("第$index条",textAlign: TextAlign.center),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            itemCount: 30,
          ),
        ),
        Expanded(
            child: child)
      ],
    );
  }
}
