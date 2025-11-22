import 'package:flutter/material.dart';

// Menggunakan import relatif yang lebih stabil di lingkungan ini
import './detail_fashion/celana.dart';
import './detail_fashion/jaket.dart';
import './detail_fashion/baju.dart';
import './detail_fashion/rok.dart';

class FashionPage extends StatelessWidget {
  const FashionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar item fashion dengan data lengkap
    final List<Map<String, dynamic>> items = [
      {
        "nama": "Polo Shirt – Union Polo Brow",
        "harga": "Rp 115.000",
        "gambar": "assets/baju.jpg",
        "deskripsi_singkat":
            "Bahan Cvc Pique (Lembut & Nyaman),Desain Simpel dan Elegan, Warna Brown (Mudah dipadukan)",
        "rating": 4.7,
        "total_rating": "1.5rb+ terjual",
        "page": const DetailBaju(),
      },
      {
        "nama": "Marks & Spencer - Skinny Fit Stretch Chinos",
        "harga": "Rp 479.920",
        "gambar": "assets/celana.jpg",
        "deskripsi_singkat":
            "Celana chino untuk smart casual look yang nyaman, Mid rise, Unlined, Skinny fit, tidak transparan, ringan dan stretchable",
        "rating": 4.8,
        "total_rating": "900+ terjual",
        "page": const DetailCelana(),
      },
      {
        "nama": "Levi's® Men's Type II Trucker Jacket",
        "harga": "Rp 1.799.900",
        "gambar": "assets/jaket.jpg",
        "deskripsi_singkat":
            "desain klasik yang terinspirasi dari arsip Levi’s® dengan sentuhan modern.",
        "rating": 4.9,
        "total_rating": "550+ terjual",
        "page": const DetailJaket(),
      },
      {
        "nama": "Rok mini plisket",
        "harga": "Rp 499.900",
        "gambar": "assets/rok.jpg",
        "deskripsi_singkat": "Rok mini A-line dari kain tenun dengan lipit.",
        "rating": 4.6,
        "total_rating": "1.8rb+ terjual",
        "page": const DetailRok(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Fashion")),

      // =================== GRIDVIEW (SAMA SEPERTI ELEKTRONIK) ===================
      body: GridView.builder(
        padding: const EdgeInsets.all(10),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // dua kolom seperti ElektronikPage
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),

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
                    // GAMBAR fashion
                    Image.asset(
                      item["gambar"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.withOpacity(0.3),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.style,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),

                    // OVERLAY GRADIENT
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

                    // TEKS BAGIAN BAWAH
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nama produk
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

                          // Rating + Harga
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Rating badge
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 12,
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
