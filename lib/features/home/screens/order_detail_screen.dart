import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color(0xFF7B1E1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: ${order['clientName']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Company: ${order['company']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Location: ${order['location']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Email: ${order['email']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            if (order['phone'] != null && order['phone'].toString().isNotEmpty)
              Text('Phone: ${order['phone']}', style: const TextStyle(fontSize: 16)),
            const Divider(height: 32),
            Text(
              'Wine: ${order['companyWine']} – ${order['wine']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Quantity: ${order['quantity']}', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order resent to distributor & Cape & Kingdom'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Resend Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/wine-selection',
                      arguments: {
                        'clientName': order['clientName'],
                        'company': order['company'],
                        'location': order['location'],
                        'email': order['email'],
                        'phone': order['phone'],
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1E1E),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

