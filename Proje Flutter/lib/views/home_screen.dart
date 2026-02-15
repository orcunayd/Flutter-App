import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/product_card.dart';
import 'package:flutter_application_2/models/product_model.dart';
import 'package:flutter_application_2/services/api_service.dart';
import 'package:flutter_application_2/views/cart_screen.dart';
import 'package:flutter_application_2/views/favorite_screen.dart';
import 'package:flutter_application_2/views/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final ApiService apiService = ApiService();

  bool isLoading = false;
  String errorMessage = "";

  List<Data> allProducts = [];
  Set<int> cartIds = {};
  Set<int> favoriteIds = {};

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductsModel data = await apiService.fetchProducts();

      setState(() {
        allProducts = data.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed To Load Products.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      IconButton(
                        iconSize: 26,
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FavoriteScreen(
                                products: allProducts,
                                favoriteIds: favoriteIds,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 26,
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartScreen(
                                products: allProducts,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                "Find Your Perfect Device",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 14),

              /// SEARCH BAR
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff5f5f7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search Products",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// BANNER
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://wantapi.com/assets/banner.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// CONTENT
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (errorMessage.isNotEmpty)
                Expanded(
                  child: Center(
                    child: Text(errorMessage),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: allProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = allProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                product: product,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
  product: product,
  isFavorite: favoriteIds.contains(product.id),
  onFavoriteToggle: () {
    setState(() {
      if (favoriteIds.contains(product.id)) {
        favoriteIds.remove(product.id);
      } else {
        favoriteIds.add(product.id!);
      }
    });
  },
),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
