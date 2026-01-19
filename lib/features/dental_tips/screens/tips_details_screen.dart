import 'package:dental_app/features/dental_tips/models/tips_model.dart';
import 'package:flutter/material.dart';


class TipDetailScreen extends StatelessWidget {
  final TipModel tip;

  const TipDetailScreen({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tip.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.lightbulb, size: 100, color: Colors.amber),
            const SizedBox(height: 32),
            Text(
              tip.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              tip.description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}