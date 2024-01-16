import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/pages/Home_page.dart';

import 'bloc/brand_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiBloc>(create: (context) => ApiBloc()),
        BlocProvider<ApiBlocApple>(create: (context) => ApiBlocApple()),
        BlocProvider<ApiBlocSamsung>(create: (context) => ApiBlocSamsung()),
        // เพิ่ม BlocProviders เพิ่มเติมสำหรับ bloc อื่นๆ
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
