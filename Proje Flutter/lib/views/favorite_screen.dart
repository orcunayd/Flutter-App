import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> favoriteIds;

  const FavoriteScreen({
    super.key,
    required this.products,
    required this.favoriteIds,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProducts = widget.products
        .where((product) => widget.favoriteIds.contains(product.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Products Yet.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      product.image ?? "",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name ?? ""),
                    subtitle: Text("${product.price} ₺"),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.favoriteIds.remove(product.id);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
