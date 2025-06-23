import 'package:flutter/material.dart';

class WineInfographic extends StatelessWidget {
  final List<Map<String, dynamic>> flavors;
  final List<Map<String, dynamic>> tasteProfile;

  const WineInfographic({
    super.key,
    required this.flavors,
    required this.tasteProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text(
          'Primary Flavors',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: flavors.map((flavor) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF7B1E1E).withAlpha(25),
                  child: Icon(flavor['icon'], color: const Color(0xFF7B1E1E), size: 24),
                ),
                const SizedBox(height: 6),
                Text(flavor['label'], style: const TextStyle(fontSize: 12)),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        const Text(
          'Taste Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...tasteProfile.map((item) => _buildTasteBar(item['label'], item['value'])),
      ],
    );
  }

  Widget _buildTasteBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFF7B1E1E),
            minHeight: 8
          ),
        ],
      ),
    );
  }
}

