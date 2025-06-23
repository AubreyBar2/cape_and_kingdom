import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedPlaceType;

  final List<String> _placeTypes = [
    'Restaurant',
    'Golf Club',
    'Bar',
    'Hotel',
    'Other',
  ];

  bool _isSubmitting = false;

  Future<void> _submitClient() async {
    if (!_formKey.currentState!.validate() || _selectedPlaceType == null) return;

    setState(() => _isSubmitting = true);

    final newClient = {
      'name': _nameController.text.trim(),
      'company': _companyController.text.trim(),
      'location': _locationController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'placeType': _selectedPlaceType,
      'timestamp': DateTime.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('clients').add(newClient);

      if (!mounted) return; // ✅ only call context if still in widget tree
      Navigator.pop(context, 'client_added');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving client: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Client'),
        backgroundColor: const Color(0xFF7B1E1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Client Information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              _buildTextField(_nameController, 'Name'),
              _buildTextField(_companyController, 'Company Name'),
              _buildTextField(_locationController, 'Location / Address'),
              _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
              _buildTextField(_phoneController, 'Phone Number', keyboardType: TextInputType.phone),

              const SizedBox(height: 16),
              const Text('Select Type of Place', style: TextStyle(fontWeight: FontWeight.bold)),

              DropdownButtonFormField<String>(
                value: _selectedPlaceType,
                items: _placeTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => _selectedPlaceType = value),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null ? 'Please select a type' : null,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitClient,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B1E1E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add New Client', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
      ),
    );
  }
}




