import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String? payload;
  const DetailScreen({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    final String? payload =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payload'),
      ),
      body: Center(
        child: Text(payload ?? 'No Payload'),
      ),
    );
  }
}
