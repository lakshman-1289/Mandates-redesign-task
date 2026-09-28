import 'package:flutter/material.dart';
import '../data/mandate_repository.dart';
import '../screens/mandates/mandates_screen.dart';
import 'theme/app_theme.dart';

/// Root application widget.
class EzfinanzApp extends StatelessWidget {
  final MandateRepository repository;

  const EzfinanzApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ezfinanz Mandates',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MandatesScreen(repository: repository),
    );
  }
}
