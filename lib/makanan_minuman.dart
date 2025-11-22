import 'package:flutter/material.dart';

// === IMPORT FILE DETAIL ===
import '../detail_makanan_minuman/detail_nasi_goreng.dart';
import '../detail_makanan_minuman/detail_ayam_geprek.dart';
import '../detail_makanan_minuman/detail_es_teh.dart';
import '../detail_makanan_minuman/detail_kopi_susu.dart';

class MakananMinumanPage extends StatelessWidget {
  const MakananMinumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menambahkan Field Rating dan Jumlah Rating untuk tampilan daftar
    final List<Map<String, dynamic>> items = [
      {
        "nama": "Nasi Goreng Spesial",
        "harga": "Rp 27.000",
        "gambar": "assets/nasi_goreng.jpg",
        "deskripsi_singkat":
            "Nasi Goreng + Telor Mata Sapi + Lalapan + Sayuran + Kerupuk + Bakso + Sosis (level 1-5).",
        "rating": 4.7,
        "total_rating": "200+ rating",
        "page": const DetailNasiGoreng(),
      },
      {
        "nama": "Ayam Geprek Sambal Bawang",
        "harga": "Rp 18.000",
        "gambar": "assets/ayam_geprek.jpg",
        "deskripsi_singkat":
            "Nasi + Ayam Krispi + Lalapan + Sambal Bawang (level 1-5).",
        "rating": 4.9,
        "total_rating": "15rb+ rating",
        "page": const DetailAyamGeprek(),
      },
      {
        "nama": "Es Teh Manis Jumbo",
        "harga": "Rp 15.000",
        "gambar": "assets/es_teh.jpg",
        "deskripsi_singkat": "Es Batu + Teh (Hijau, Lemon, Lychee, Mint).",
        "rating": 4.5,
        "total_rating": "50+ rating",
        "page": const DetailEsTehJumbo(),
      },
      {
        "nama": "Kopi Susu Gula Aren",
        "harga": "Rp 22.000",
        "gambar": "assets/kopi_susu.jpg",
        "deskripsi_singkat": "Kopi Hitam + Susu Segar + Gula Aren + Es Batu.",
        "rating": 4.8,
        "total_rating": "1rb+ rating",
        "page": const DetailKopiSusuGulaAren(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Makanan & Minuman")),
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
                    // ============== GAMBAR BACKGROUND ==============
                    Image.asset(item["gambar"], fit: BoxFit.cover),
                    // ============== OVERLAY GRADIENT ==============
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
                    // ============== DETAIL TEKS (BAWAH) ==============
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nama Menu
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
                          // Deskripsi Singkat
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
                          // Rating dan Harga (Baris Bawah)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Rating dengan Badge
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
                                      '${item["rating"]}',
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
