import 'package:flutter/material.dart';
import 'order_preview_screen.dart';

class WineSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> clientInfo;
  final Map<String, dynamic>? selectedWine;

  const WineSelectionScreen({
    super.key,
    required this.clientInfo,
    this.selectedWine,
  });

  @override
  State<WineSelectionScreen> createState() => _WineSelectionScreenState();
}

class _WineSelectionScreenState extends State<WineSelectionScreen> {
  final Map<String, int> _selectedQuantities = {};

  final List<Map<String, dynamic>> redWines = [
    {'company': 'De Grendel', 'cultivar': 'Merlot', 'image': 'assets/images/merlot.png'},
    {'company': 'Diemersdal', 'cultivar': 'Pinotage', 'image': 'assets/images/pinotage.png'},
  ];

  final List<Map<String, dynamic>> whiteWines = [
    {'company': 'Plaisir', 'cultivar': 'Chenin Blanc', 'image': 'assets/images/chenin_blanc.png'},
    {'company': 'Fat Bastard', 'cultivar': 'Sauvignon Blanc', 'image': 'assets/images/sauvignon_blanc.png'},
  ];

  final List<Map<String, dynamic>> roseWines = [
    {'company': 'De Grendel', 'cultivar': 'Pinotage Rosé', 'image': 'assets/images/pinotage_rose.png'},
    {'company': 'Fat Bastard', 'cultivar': 'Rosé', 'image': 'assets/images/fat_rose.png'},
  ];

  void _adjustQuantity(String key, int change) {
    setState(() {
      _selectedQuantities[key] = (_selectedQuantities[key] ?? 0) + change;
      if (_selectedQuantities[key]! < 0) _selectedQuantities[key] = 0;
    });
  }

  void _submitOrder() {
    final selected = _selectedQuantities.entries.where((e) => e.value > 0).map((e) {
      final split = e.key.split(':');
      final category = split[0];
      final index = int.parse(split[1]);
      final wine = category == 'red'
          ? redWines[index]
          : category == 'white'
          ? whiteWines[index]
          : roseWines[index];
      return {
        'company': wine['company'],
        'cultivar': wine['cultivar'],
        'image': wine['image'],
        'quantity': e.value
      };
    }).toList();

    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one wine')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderPreviewScreen(
          clientInfo: widget.clientInfo,
          selectedWines: selected,
        ),
      ),
    );
  }

  Widget _buildWineCard(Map<String, dynamic> wine, String category, int index) {
    final key = '$category:$index';
    final quantity = _selectedQuantities[key] ?? 0;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 6, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(wine['image'], height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(wine['company'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(wine['cultivar'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _adjustQuantity(key, -1),
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _adjustQuantity(key, 1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Map<String, dynamic>> wines, String categoryKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: wines.length,
            itemBuilder: (_, index) => _buildWineCard(wines[index], categoryKey, index),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Wines'),
        backgroundColor: const Color(0xFF7B1E1E),
      ),
      body: ListView(
        children: [
          _buildCategorySection('Red Wines', redWines, 'red'),
          _buildCategorySection('White Wines', whiteWines, 'white'),
          _buildCategorySection('Rosé Wines', roseWines, 'rose'),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B1E1E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Submit Order', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}



