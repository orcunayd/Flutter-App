import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/models/product_model.dart';
import 'package:flutter_application_2/views/payment_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Data>products;
  final Set<int>cartIds;
  const CartScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
                         .where((product)=> widget.cartIds.contains(product.id))
                         .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: cartProducts.isEmpty
    ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              "Your Cart Is Empty.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      )
    : SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final item = cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.image!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(item.tagline!),
                              Text(
                                item.price!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              widget.cartIds.remove(item.id);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const PaymentScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    
  }
}
