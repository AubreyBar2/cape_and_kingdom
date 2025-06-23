// 📄 home_screen.dart
import 'package:flutter/material.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/order_dashboard_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/wine_detail_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFFF4ECE4),
              child: Column(
                children: [
                  _buildNavigationBar(),
                  const HeroSearchBar(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Popular Red Wines',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildWineCardWithTap(
                    'Plaisir',
                    'Cabernet Sauvignon',
                    'assets/images/cabernet.png',
                    'Full-bodied with blackcurrant notes.',
                  ),
                  _buildWineCardWithTap(
                    'Fat Bastard',
                    'Shiraz / Syrah',
                    'assets/images/shiraz.png',
                    'Spicy, smoky, bold dark fruit.',
                  ),
                  _buildWineCardWithTap(
                    'Diemersdal',
                    'Pinotage',
                    'assets/images/pinotage.png',
                    'South Africa’s earthy signature cultivar.',
                  ),
                  _buildWineCardWithTap(
                    'De Grendel',
                    'Merlot',
                    'assets/images/merlot.png',
                    'Smooth, medium-bodied, red berries.',
                    flavors: [
                      {'label': 'Cherry', 'icon': Icons.local_pizza},
                      {'label': 'Plum', 'icon': Icons.local_florist},
                      {'label': 'Chocolate', 'icon': Icons.cake},
                      {'label': 'Bay Leaf', 'icon': Icons.eco},
                      {'label': 'Vanilla', 'icon': Icons.icecream},
                    ],
                    tasteProfile: [
                      {'label': 'Bone-Dry', 'value': 0.2},
                      {'label': 'Medium-Full Body', 'value': 0.8},
                      {'label': 'Medium-High Tannin', 'value': 0.8},
                      {'label': 'Medium Acidity', 'value': 0.5},
                      {'label': '13.5–15% ABV', 'value': 0.8},
                    ],
                    videoUrl: 'https://www.youtube.com/watch?v=pGOwfJVxBtQ&t=29s',
                    galleryImages: [
                      'assets/images/degrendel_farm_1.jpg',
                      'assets/images/degrendel_farm_2.jpg',
                      'assets/images/degrendel_farm_3.jpg',
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Popular White Wines',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildWineCardWithTap('Plaisir', 'Chenin Blanc', 'assets/images/chenin_blanc.png', 'Versatile from dry to sweet styles.'),
                  _buildWineCardWithTap('Fat Bastard', 'Sauvignon Blanc', 'assets/images/sauvignon_blanc.png', 'Crisp, citrusy, grassy.'),
                  _buildWineCardWithTap('Diemersdal', 'Gruner Veltiliner', 'assets/images/Gruner_Veltiliner.png', 'Fresh and fruity, great for warm climates.'),
                  _buildWineCardWithTap('De Grendel', 'Chardonnay', 'assets/images/chardonnay.png', 'Rich with citrus and buttery notes.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Popular Rosé Wines',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildWineCardWithTap('Vrede & Lust', 'Jess Rosé', 'assets/images/jess_rose.png', 'Light bodied and bursting with aromas.'),
                  _buildWineCardWithTap('Fat Bastard', 'Rosé', 'assets/images/fat_rose.png', 'Bright and fruity dry rosé.'),
                  _buildWineCardWithTap('Diemersdal', 'Sauvignon Rosé', 'assets/images/sauvignon_rose.png', 'Fruity and vibrant South African rosé.'),
                  _buildWineCardWithTap('De Grendel', 'Pinotage Rosé', 'assets/images/pinotage_rose.png', 'Soft, smooth, and easy-drinking rosé.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWineCardWithTap(
      String company,
      String cultivar,
      String imagePath,
      String description, {
        List<Map<String, dynamic>> flavors = const [],
        List<Map<String, dynamic>> tasteProfile = const [],
        String videoUrl = '',
        List<String> galleryImages = const [],
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WineDetailScreen(
              wine: {
                'company': company,
                'cultivar': cultivar,
                'image': imagePath,
                'description': description,
                'flavors': flavors,
                'tasteProfile': tasteProfile,
                'videoUrl': videoUrl,
                'galleryImages': galleryImages,
              },
            ),
          ),
        );
      },
      child: _buildWineCard(company, cultivar, imagePath, description),
    );
  }

  Widget _buildNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/ck_logo_home_logo.png', height: 76),
          const Spacer(),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavItem('Home', 'assets/images/home_icon.png', 0),
                _buildNavItem('Orders', 'assets/images/order_icon.png', 1),
                _buildNavItem('Contact', 'assets/images/phone_icon.png', 2),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.language), onPressed: () {}),
              const SizedBox(width: 8),
              IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String assetPath, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const OrderDashboardScreen(),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(assetPath, height: 40),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 6),
                height: 2,
                width: 48,
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWineCard(String company, String title, String imagePath, String description) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(imagePath, height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(company, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description, style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroSearchBar extends StatelessWidget {
  const HeroSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Container(
          width: 600,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search wine, farm, or region',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF7B1E1E),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.search, size: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









