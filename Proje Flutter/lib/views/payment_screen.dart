import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Common
  final TextEditingController nameController = TextEditingController();

  // Card
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // IBAN
  final TextEditingController ibanController = TextEditingController();

  String selectedPaymentMethod = "card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Payment Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// NAME
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name Surname",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// PAYMENT METHOD
              const Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              RadioListTile(
                value: "card",
                groupValue: selectedPaymentMethod,
                title: const Text("Credit Card"),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),

              RadioListTile(
                value: "iban",
                groupValue: selectedPaymentMethod,
                title: const Text("Bank Transfer (IBAN)"),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),

              const SizedBox(height: 10),

              /// CARD FORM
              if (selectedPaymentMethod == "card") ...[
                TextFormField(
                  controller: cardNumberController,
                  decoration: const InputDecoration(
                    labelText: "Card Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.replaceAll(" ", "").length < 16) {
                      return "Invalid card number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: expiryController,
                        decoration: const InputDecoration(
                          labelText: "MM/YY",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Invalid date";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: cvvController,
                        decoration: const InputDecoration(
                          labelText: "CVV",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length != 3) {
                            return "Invalid CVV";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],

              /// IBAN FORM
              if (selectedPaymentMethod == "iban") ...[
                TextFormField(
                  controller: ibanController,
                  decoration: const InputDecoration(
                    labelText: "IBAN",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return "Invalid IBAN";
                    }
                    return null;
                  },
                ),
              ],

              const Spacer(),

              /// PAY BUTTON
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _showSuccessDialog(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Complete Payment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful"),
        content: const Text(
          "Your payment has been completed successfully.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // dialog
              Navigator.pop(context); // payment
              Navigator.pop(context); // cart
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
