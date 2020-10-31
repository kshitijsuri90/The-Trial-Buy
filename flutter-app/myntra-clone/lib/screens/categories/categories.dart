import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/categories/category.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            color: Theme.of(context).accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Category(
                      'BIG FASHION FESTIVAL',
                      'Top Offers, Apparel, Footware',
                      ['Top Offers', 'Men', 'Women', 'Kids', 'Festive'],
                      Colors.yellowAccent.shade100),
                  Category(
                      'WOMEN',
                      'Kurtas & Suits, Top & Tees',
                      [
                        'Westernwear',
                        'Ethnicwear',
                        'Bags, Wallets & Clutches',
                        'Jewellery'
                      ],
                      Colors.pinkAccent.shade100),
                  Category(
                      'MEN',
                      'T-Shirts, Shirts, Jeans',
                      ['Topwear', 'Footwear', 'Watches', 'Sports & Activewear'],
                      Colors.orangeAccent.shade100),
                  Category(
                      'KIDS',
                      'Brands, Clothing, Footwear',
                      ['Explore Kids Store', 'Infants', 'Masks'],
                      Colors.purpleAccent.shade100),
                  Category(
                      'MYNTRA MALL',
                      'H&M, Nike, Smashbox',
                      ['Explore Myntra Mall', 'Casio', 'HRX', 'Nike', 'Wrogn'],
                      Colors.pink.shade100),
                  Category(
                      'GADGETS',
                      'Head phones, Smart wearables',
                      [
                        'Smart Wearables',
                        'Audio & Hearables',
                        'Mobile Accessories'
                      ],
                      Colors.teal.shade100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
