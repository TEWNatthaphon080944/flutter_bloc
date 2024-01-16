import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<Map<String, String>> selectedItems;

  const ShoppingCartPage({Key? key, required this.selectedItems})
      : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late List<int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = List.generate(widget.selectedItems.length, (index) => 1);
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int i = 0; i < widget.selectedItems.length; i++) {
      final item = widget.selectedItems[i];
      final quantity = quantities[i];
      final price = double.tryParse(item['price'] ?? '0.0') ?? 0.0;
      totalPrice += (price * quantity);
    }
    return totalPrice;
  }

  void checkout() {
    // Implement your checkout logic here
    // For simplicity, let's just display a success message for demonstration purposes
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('You have successfully paid \$${calculateTotalPrice().toStringAsFixed(2)}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Close the dialog and navigate to another page if needed
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.selectedItems.isEmpty
                ? const Text('No selected items')
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.selectedItems[index];
                        final quantity = quantities[index];

                        return ListTile(
                          leading: Image.network(
                            item['image'] ??
                                'https://example.com/placeholder.jpg',
                            width: 50,
                            height: 50,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          title: Text(item['name']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: ${item['price'] ?? "N/A"}'),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantities[index]--;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text('จำนวน: $quantity'),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantities[index]++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ยอดเงินชำระ: \$${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: checkout, // Call the checkout function when the button is pressed
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 62, 255, 3),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ชำระเงิน',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
