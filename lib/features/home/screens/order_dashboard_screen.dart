import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({super.key});

  @override
  State<OrderDashboardScreen> createState() => _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Dashboard'),
        backgroundColor: const Color(0xFF7B1E1E),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Clients',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // 📄 Client List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('clients')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No clients yet'));
                }

                final clients = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final name = data['name']?.toLowerCase() ?? '';
                  final company = data['company']?.toLowerCase() ?? '';
                  return name.contains(_searchQuery) || company.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final doc = clients[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        title: Text(data['name'] ?? 'No Name'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data['company']} • ${data['placeType']}'),
                            const SizedBox(height: 4),

                            // 📦 Recent Orders Section
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('clientID', isEqualTo: doc.id)
                                  .orderBy('date', descending: true)
                                  .limit(3)
                                  .snapshots(),
                              builder: (context, orderSnapshot) {
                                if (orderSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Text('Loading recent orders...');
                                }

                                if (!orderSnapshot.hasData || orderSnapshot.data!.docs.isEmpty) {
                                  return const Text('No recent orders.');
                                }

                                final orders = orderSnapshot.data!.docs;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: orders.map((orderDoc) {
                                    final order = orderDoc.data() as Map<String, dynamic>;
                                    final date = (order['date'] as Timestamp).toDate();
                                    final wines = List<Map<String, dynamic>>.from(order['wines']);

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '• ${date.day}/${date.month}/${date.year}',
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                          ...wines.map((wine) => Text('  - ${wine['name']} × ${wine['quantity']}')),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/wine-selection',
                            arguments: {
                              'clientInfo': {
                                'id': doc.id, // ✅ Include Firestore doc ID here!
                                'name': data['name'],
                                'company': data['company'],
                                'email': data['email'],
                                'phone': data['phone'],
                                'location': data['location'],
                                'placeType': data['placeType'],
                              }
                            },
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final safeContext = context;
                                final result = await Navigator.pushNamed(
                                  safeContext,
                                  '/edit-client',
                                  arguments: {'client': data, 'id': doc.id},
                                );
                                if (!mounted) return;
                                if (result == 'client_edited') {
                                  ScaffoldMessenger.of(safeContext).showSnackBar(
                                    const SnackBar(content: Text('Client updated')),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Delete Client'),
                                    content: const Text('Are you sure you want to delete this client?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await FirebaseFirestore.instance.collection('clients').doc(doc.id).delete();
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Client deleted')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ➕ Add New Client FAB
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF7B1E1E),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Add New Client', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add-client');

          if (!context.mounted) return;

          if (result == 'client_added') {
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Client added successfully!')),
            );
          }
        },
      ),
    );
  }
}








