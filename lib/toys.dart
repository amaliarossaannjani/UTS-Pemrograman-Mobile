import 'package:flutter/material.dart';

// Import relatif untuk detail produk mainan
import './detail_toys/bola.dart';
import './detail_toys/boneka.dart';

class ToysPage extends StatelessWidget {
  const ToysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "nama": "FUTBOL Bola Futsal Soccer Ball Bola Sepak Karet Bulat",
        "harga": "Rp 49.000",
        "gambar": "assets/bola.jpg",
        "deskripsi_singkat":
            "Bola Karet, berbentuk bulat sempurna, cocok untuk bermain futsal/sepak bola mini.",
        "rating": 4.9,
        "total_rating": "2.1rb+ terjual",
        "page": const DetailBola(),
      },
      {
        "nama":
            "MINISO Boneka Seri TOY Story Lotso Bear Strawberry Plush Toy Boneka Lucu",
        "harga": "Rp 132.900",
        "gambar": "assets/boneka.jpg",
        "deskripsi_singkat":
            "Boneka Lotso dari TOY Story, bahan lembut dan cocok sebagai kado.",
        "rating": 4.7,
        "total_rating": "3.5rb+ terjual",
        "page": const DetailBoneka(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Mainan")),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),

        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item["page"]),
              );
            },

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // ========== GAMBAR ==========
                    Image.asset(
                      item["gambar"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.withOpacity(0.3),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.toys,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),

                    // ========== OVERLAY ==========
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),

                    // ========== TEKS (POSISI BAWAH) ==========
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama
                          Text(
                            item["nama"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Deskripsi singkat
                          Text(
                            item["deskripsi_singkat"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Rating & Harga
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Badge Rating
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      "${item["rating"]}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Harga
                              Text(
                                item["harga"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
