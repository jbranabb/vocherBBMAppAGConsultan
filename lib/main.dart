import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocherbbmt/pages/pdf_page.dart';
import 'package:vocherbbmt/pages/textInput_page.dart';
import 'package:vocherbbmt/provider/vocher_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => VoucherProvider()))
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          centerTitle: true,
          color: Colors.blue.shade900,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 33, 177, 243)),
        useMaterial3: true,
      ),
      home:InputPage(), 
      
  );
  }
}

