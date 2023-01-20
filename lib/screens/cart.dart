// ignore_for_file: use_key_in_widget_constructors

import 'package:ecommerce_flutter_app/screens/product_details.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/cart_list.dart';
import 'product_card.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool showStarred = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 8, left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const NuovoPrezzo(),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Column(
                  children: buildProductCards(cart, context, showStarred),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ProductCard> buildProductCards(
      List<Product> productList, BuildContext context, bool showStarred) {
    List<ProductCard> productCards = [];
    for (var product in productList) {
      final productCard = ProductCard(
          product: product,
          onTap: (product) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(
                  product: product,
                ),
              ),
            );
          });

      productCards.add(productCard);
    }

    return productCards;
  }
}

class PrezzoCarrello extends StatelessWidget {
  const PrezzoCarrello({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.00),
          border: Border.all(
            color: const Color(0xff06D6A0),
            width: 2.5,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(200, 134, 214, 254),
                blurRadius: 5,
                spreadRadius: 0.05),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cart.length}',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Prodotti',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xff06D6A0),
                // width: double.infinity,
                child: Center(
                  child: Text(
                    '\$${sumPrices(cart).round()}',
                    style: const TextStyle(
                        fontSize: 50,
                        color: Color(0xff3CEB6C),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class NuovoPrezzo extends StatelessWidget {
  const NuovoPrezzo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
                border: Border.all(
                  color: const Color(0xff06D6A0),
                  width: 2.7,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Center(
              child: Column(
                children: [
                  Text(
                    '${cart.length}',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Prodotti',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff06D6A0),
                  width: 2.5,
                ),
                color: const Color(0xff06D6A0),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                '\$${sumPrices(cart).round()}',
                style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }
}

double sumPrices(List<Product> list) {
  double sum = 0;

  for (int i = 0; i < list.length; i++) {
    sum += list[i].price;
  }

  return sum;
}
