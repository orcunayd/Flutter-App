import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int>cartIds;
  const ProductDetailScreen({super.key, required this.product, required this.cartIds});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Back", style: TextStyle(color: Colors.black),),
          leadingWidth: 20,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id!,
                child: Image.network(widget.product.image ?? "", 
                height: 350, 
                width: double.infinity,
                fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 2),
              Padding(padding: EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name ?? "",
                  style: TextStyle(fontSize: 28, fontWeight: 
                  FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(widget.product.tagline ?? "",
                  style: TextStyle(fontStyle: FontStyle.italic, 
                  color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text("Description", style: TextStyle(fontSize: 24, 
                  fontWeight: FontWeight.bold, 
                  decoration: TextDecoration.underline),
                  ),
                  SizedBox(height: 2),
                  Text(widget.product.description ?? ""),
                  SizedBox(height: 10),
                  Text(widget.product.price ?? "", style: TextStyle(fontWeight: FontWeight.bold, 
                  color: Colors.blue.shade800, 
                  fontSize: 28),
                  ),
                  SizedBox(height: 14),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      widget.cartIds.add(widget.product.id!);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added To Cart"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green.shade600,
                      margin: EdgeInsets.only(
                        bottom: 120,
                        left: 20,
                        right: 20,
                      ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                  ), 
                  child: Text("Add To Cart", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),),
            ],
          ),
        )),
      ),
    );
  }
}