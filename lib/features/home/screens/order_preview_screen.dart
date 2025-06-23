import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderPreviewScreen extends StatelessWidget {
  final Map<String, dynamic> clientInfo;
  final List<Map<String, dynamic>> selectedWines;

  const OrderPreviewScreen({super.key, required this.clientInfo, required this.selectedWines});

  void _confirmOrder(BuildContext context) async {
    final orderId = const Uuid().v4();
    final now = DateTime.now();

    final orderData = {
      'clientID': clientInfo['id'] ?? '',
      'clientName': clientInfo['name'],
      'company': clientInfo['company'],
      'email': clientInfo['email'],
      'phone': clientInfo['phone'],
      'location': clientInfo['location'],
      'placeType': clientInfo['placeType'],
      'wines': selectedWines,
      'date': now,
      'orderId': orderId,
    };

    await FirebaseFirestore.instance.collection('orders').doc(orderId).set(orderData);

    // Simulate sending email (for now, print to console)
    print("Order sent to distributor@example.com and capeandkingdom@example.com:");
    print(orderData);

    // Show confirmation dialog
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Order Confirmed'),
          content: const Text('Order has been sent to distributor and Cape & Kingdom.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Done'),
            )
          ],
        ),
      );
    }
  }

  Widget _buildWineSummary(Map<String, dynamic> wine) {
    return ListTile(
      leading: Image.asset(wine['image'], height: 48),
      title: Text('${wine['company']} – ${wine['cultivar']}'),
      trailing: Text('x${wine['quantity']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Preview'),
        backgroundColor: const Color(0xFF7B1E1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: ${clientInfo['name']} (${clientInfo['company']})'),
            Text('Location: ${clientInfo['location']}'),
            Text('Email: ${clientInfo['email']}'),
            Text('Phone: ${clientInfo['phone']}'),
            const SizedBox(height: 12),
            Text('Order Date: $formattedDate'),
            const SizedBox(height: 24),
            const Text('Selected Wines:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: selectedWines.length,
                itemBuilder: (context, index) => _buildWineSummary(selectedWines[index]),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _confirmOrder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B1E1E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Confirm Order', style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
