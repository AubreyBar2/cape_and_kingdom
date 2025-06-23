import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'wine_infographic.dart';

class WineDetailScreen extends StatefulWidget {
  final Map<String, dynamic> wine;

  const WineDetailScreen({super.key, required this.wine});

  @override
  State<WineDetailScreen> createState() => _WineDetailScreenState();
}

class _WineDetailScreenState extends State<WineDetailScreen> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.wine['videoUrl'] ?? '') ?? '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wine = widget.wine;
    final isWide = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(wine['cultivar'] ?? 'Wine Detail'),
        backgroundColor: const Color(0xFF7B1E1E),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isWide ? _buildWideLayout(wine) : _buildNarrowLayout(wine),
      ),
    );
  }

  Widget _buildWideLayout(Map<String, dynamic> wine) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            wine['image'],
            height: 400,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
            child: _buildContent(wine),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(Map<String, dynamic> wine) {
    return ListView(
      children: [
        Image.asset(
          wine['image'],
          height: 240,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        _buildContent(wine),
      ],
    );
  }

  Widget _buildContent(Map<String, dynamic> wine) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wine['company'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          wine['cultivar'],
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 24),

        WineInfographic(
          flavors: wine['flavors'] ?? [],
          tasteProfile: wine['tasteProfile'] ?? [],
        ),

        const SizedBox(height: 24),
        const Text("Select Order Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/order-dashboard');
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Go to Orders'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/add-client');
                if (!mounted || result == null || result == 'client_cancelled') return;
                Navigator.pushNamed(
                  context,
                  '/wine-selection',
                  arguments: {
                    'clientInfo': result,
                    'selectedWine': wine,
                  },
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('New Client Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B1E1E),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),
        const Text(
          'Wine Farm Gallery & Video',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (widget.wine['videoUrl'] != null && widget.wine['videoUrl'].toString().isNotEmpty)
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
          )
        else
          Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(child: Text('No video available')),
          ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (widget.wine['galleryImages'] ?? []).map<Widget>((imagePath) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: InteractiveViewer(
                        child: Image.asset(imagePath, fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}







