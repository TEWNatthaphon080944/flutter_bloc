import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/bloc/brand_bloc.dart';

import '../cart/shoppind_cart.dart';

class ApplePage extends StatefulWidget {
  const ApplePage({Key? key});

  @override
  State<ApplePage> createState() => _ApplePageState();
}

class _ApplePageState extends State<ApplePage> {
  late ApiBlocApple apiBlocApple;
  List<Map<String, String>> selectedItems = []; // Define a list to hold selected items

  @override
  Widget build(BuildContext context) {
    apiBlocApple = BlocProvider.of<ApiBlocApple>(context);
    apiBlocApple.add(FetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product : Apple'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<ApiBlocApple, ApiState>(
          builder: (context, state) {
            if (state.data1.isNotEmpty) {
              final List<Map<String, String>> data1 = state.data1;
              print('API DataAppleX: $data1');
              return ListView.builder(
                itemCount: data1.length,
                itemBuilder: (context, index) {
                  final item = data1[index];
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: 90,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          leading: Image.network(
                            item['image']!,
                            width: 80,
                            height: 80,
                          ),
                          title: Text(item['name']!),
                          subtitle: Text('ราคา: ${item['price']}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedItems.add(item); // Add selected item to the list
                              });
                              print('เลือกรายการ: ${item['name']}');
                            },
                            child: const Text('+'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state.data.isEmpty) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            } else {
              return const Text("Error occurred!");
            }
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60.0,
        child: BottomAppBar(
            color: Color.fromARGB(255, 255, 85, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    selectedItems.isEmpty
                        ? "ไม่มีสินค้าในตะกร้า"
                        : "มีสินค้าในตะกร้า ${selectedItems.length} ชิ้น",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: selectedItems.isEmpty
                          ? Color.fromARGB(255, 61, 255, 13)
                         : const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 35.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoppingCartPage(
                              selectedItems: selectedItems,
                            ),
                          ),
                        );
                      },
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
