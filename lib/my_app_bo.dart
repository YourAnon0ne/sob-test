import 'package:flutter/material.dart';
import 'package:tswork/home_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final pointsProvider = useState<List<Offset?>>([]);
    // final isDrawing = useState<bool>(false);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
