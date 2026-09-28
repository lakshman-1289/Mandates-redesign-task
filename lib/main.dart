import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'data/mock_mandate_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure modern edge-to-edge transparent system overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final mandateRepository = MockMandateRepository();

  runApp(EzfinanzApp(repository: mandateRepository));
}
