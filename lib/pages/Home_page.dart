import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/bloc/brand_bloc.dart';
import 'package:shop/cart/shoppind_cart.dart';

import 'Apple_page.dart';
import 'samsung_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiBloc apiBloc;

  @override
  Widget build(BuildContext context) {
    apiBloc = BlocProvider.of<ApiBloc>(context);// เพื่อเข้าถึง instance
    apiBloc.add(FetchDataEvent());//เรียกใช้เหตุการณ์ FetchDataEvent() บน apiBloc เพื่อดึงข้อมูลจากแหล่งข้อมูล.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand'),
      ),
      body: Center(
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state.data.isNotEmpty) {
              final List<Map<String, String>> data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.5, 
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          leading: Image.network(
                            item['logo']!,
                            width: 60,
                            height: 60,
                          ),
                          title: Text(item['name']!),
                          onTap: () {
                            if (item['name'] == 'Apple') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ApplePage(),
                                ),
                              );
                            } else if (item['name'] == 'Samsung') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SamsungPage(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state.data.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text("Error occurred!");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShoppingCartPage(selectedItems: [],)),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
