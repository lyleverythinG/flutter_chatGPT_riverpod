import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/features/screens/chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
