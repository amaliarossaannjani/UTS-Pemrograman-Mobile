import 'package:flutter/material.dart';

// Mengubah nama kelas menjadi DetailMesinCuci
class DetailMesinCuci extends StatelessWidget {
  const DetailMesinCuci({super.key});

  // Data statis untuk detail item Mesin Cuci
  static const String namaMenu =
      "LG Mesin Cuci Front Loading 8.5 KG - FV1285S3VS";
  static const int priceValue = 5550000;
  static const String hargaTetap = "Rp 5.550.000";
  static const String gambarPath = "assets/mesin_cuci.jpg";

  // Spesifikasi Mesin Cuci
  static const List<Map<String, String>> specs = [
    {"label": "Type", "value": "LG Front Loading"},
    {"label": "Kapasitas", "value": "8.5 kg"},
    {"label": "Spin Speed", "value": "1,200/1,000/800/600/400/No Spin"},
    {"label": "Smart Feature", "value": "ThinQ"},
    {"label": "Temperatur Variabel", "value": "Cold/20/30/40/60/95℃"},
    {"label": "Dimensi (PxTxL)", "value": "600 x 850 x 565 mm"},
    {"label": "Berat", "value": "56 kg"},
    {"label": "Garansi", "value": "Garansi LG 1 Tahun"},
    {"label": "SKU", "value": "FV1285S3VS"},
  ];

  static final Color _darkGreyColor = Colors.grey.shade700;

  void _showSnackbar(BuildContext context, String message) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.secondaryContainer,
        content: Text(
          message,
          style: TextStyle(
            color: colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Widget _buildSpecRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(": ", style: TextStyle(color: colorScheme.onSurfaceVariant)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String totalHargaDisplay = hargaTetap;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(namaMenu, style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.share, color: colorScheme.onSurface),
              onPressed: () => _showSnackbar(context, "Berhasil Dibagikan!"),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============== BAGIAN GAMBAR (HEADER) ==============
                Container(
                  width: double.infinity,
                  color: colorScheme.surfaceVariant,
                  child: Image.asset(
                    gambarPath,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 400,
                        alignment: Alignment.center,
                        color: colorScheme.surfaceVariant,
                        child: Text(
                          "Gambar Mesin Cuci tidak ditemukan",
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),

                // ============== DETAIL PRODUK ==============
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaMenu,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            hargaTetap,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 32),

                      Text(
                        "Deskripsi & Spesifikasi:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...specs.map(
                        (spec) => _buildSpecRow(
                          context,
                          spec["label"]!,
                          spec["value"]!,
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ============= TOMBOL BAWAH =============
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withOpacity(
                      colorScheme.brightness == Brightness.dark ? 0.2 : 0.1,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () =>
                          _showSnackbar(context, 'Disimpan ke Favorit!'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: _darkGreyColor.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(Icons.bookmark_border, color: _darkGreyColor),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _showSnackbar(
                            context,
                            '$namaMenu (Harga: $totalHargaDisplay) ditambahkan ke keranjang!',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Tambahkan ($totalHargaDisplay)",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
