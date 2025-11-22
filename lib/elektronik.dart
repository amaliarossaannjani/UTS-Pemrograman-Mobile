import 'package:flutter/material.dart';

// Catatan: Asumsikan Anda akan membuat file detail ini di masa depan
import '../detail_elektronik/detail_kulkas.dart';
import '../detail_elektronik/detail_tv.dart';
import '../detail_elektronik/detail_mesin_cuci.dart';
import '../detail_elektronik/detail_oven.dart';

class ElektronikPage extends StatelessWidget {
  const ElektronikPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Kategori Elektronik
    final List<Map<String, dynamic>> items = [
      {
        "nama": "Sharp Kulkas Side By Side 608 L - SJ-X65WB SL",
        "harga": "Rp 17.050.000",
        "gambar": "assets/kulkas.jpg",
        "deskripsi_singkat":
            "Memiliki Kapasitas 577 Liter dengan Dispenser Es dan Air. Kulkas 173 Watt menggunakan sistem Fan Cooling otomatis.",
        "rating": 4.8,
        "total_rating": "800+ rating",
        "page": const DetailKulkas(),
      },
      {
        "nama":
            "Samsung LED Smart TV 50 Inch 4K Crystal UHD U8000F 2025 - 50U8000",
        "harga": "Rp 5.050.000",
        "gambar": "assets/tv.jpg",
        "deskripsi_singkat":
            "Menawarkan Resolusi 4K dan didukung Crystal Processor 4K untuk kualitas gambar superior, fitur Smart TV Tizen, suara Object Tracking Sound (OTS) Lite.",
        "rating": 4.9,
        "total_rating": "1.2rb+ rating",
        "page": const DetailTV(),
      },
      {
        "nama": "LG Mesin Cuci Front Loading 8.5 KG - FV1285S3VS",
        "harga": "Rp 5.550.000",
        "gambar": "assets/mesin_cuci.jpg",
        "deskripsi_singkat":
            "Memiliki Kapasitas 8.5 kg dengan Spin Speed hingga 1.200 RPM, dilengkapi fitur Smart ThinQ dan Temperatur Variabel hingga 95°C.",
        "rating": 4.6,
        "total_rating": "350+ rating",
        "page": const DetailMesinCuci(),
      },
      {
        "nama": "Panasonic Oven - NT-H900KSR",
        "harga": "Rp 625.000",
        "gambar": "assets/oven.jpg",
        "deskripsi_singkat":
            "Memiliki Kapasitas 9 Liter dengan rentang Pengaturan Suhu 70–230℃.",
        "rating": 4.7,
        "total_rating": "500+ rating",
        "page": const DetailOven(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Barang Elektronik")),

      // Menggunakan GridView.builder dengan struktur dari MakananMinumanPage
      body: GridView.builder(
        padding: const EdgeInsets.all(10),

        // Grid Delegate untuk 2 kolom
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
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

            // Struktur UI Grid Card
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
                    // GAMBAR BACKGROUND
                    Image.asset(item["gambar"], fit: BoxFit.cover),

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

                    // DETAIL TEKS (BAWAH)
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nama Produk
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

                          // Rating & Harga
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Rating Badge
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
