import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/products/product_list.dart';

class Category extends StatefulWidget {
  final String categoryName;
  final String categoryDescription;
  final List<String> subCategories;
  final Color backgroundColor;

  Category(this.categoryName, this.categoryDescription, this.subCategories,
      this.backgroundColor);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 3),
              color: widget.backgroundColor,
              width: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).padding.left -
                      MediaQuery.of(context).padding.right) *
                  1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categoryName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.categoryDescription,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isExpanded)
          ...widget.subCategories.map((e) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ProductList.routeName);
              },
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
      ],
    );
  }
}
