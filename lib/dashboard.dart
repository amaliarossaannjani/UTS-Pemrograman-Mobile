import 'package:flutter/material.dart';
import 'theme_controller.dart';
import 'makanan_minuman.dart';
import 'elektronik.dart';
import 'fashion.dart';
import 'toys.dart';
import 'jawaban no4.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Makanan & Minuman',
      'icon': Icons.fastfood,
      'page': const MakananMinumanPage(),
      'lightColor': const Color(0xFFFF6B6B),
      'darkColor': const Color(0xFF8B4545),
    },
    {
      'name': 'Elektronik',
      'icon': Icons.devices,
      'page': const ElektronikPage(),
      'lightColor': const Color(0xFF4ECDC4),
      'darkColor': const Color(0xFF2D5F5A),
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'page': const FashionPage(),
      'lightColor': const Color(0xFFFFD93D),
      'darkColor': const Color(0xFF8B7D3D),
    },
    {
      'name': 'Toys / Mainan',
      'icon': Icons.toys,
      'page': ToysPage(),
      'lightColor': const Color(0xFFA8E6CF),
      'darkColor': const Color(0xFF4D7D6F),
    },
    {
      'name': 'Jawaban Nomor 4',
      'icon': Icons.book,
      'page': Jawaban(),
      'lightColor': const Color.fromARGB(255, 221, 168, 230),
      'darkColor': const Color.fromARGB(255, 121, 77, 125),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "MyShop Mini",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: ThemeController.themeNotifier,
            builder: (_, mode, __) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: IconButton(
                  icon: Icon(
                    mode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 20,
                  ),
                  onPressed: () {
                    ThemeController.toggleTheme();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: isDarkMode
                    ? [Colors.grey[900]!, Colors.grey[850]!]
                    : [
                        Colors.blue.withOpacity(0.05),
                        Colors.purple.withOpacity(0.05),
                      ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Kategori Belanja",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      return _buildCategoryCard(context, item);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> item) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? item['darkColor'] : item['lightColor'];

    return InkWell(
      onTap: () {
        if (item['page'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['page']),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${item['name']} belum tersedia."),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cardColor, cardColor.withOpacity(0.8)],
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              top: -15,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: Icon(item['icon'], size: 26, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item['name'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
