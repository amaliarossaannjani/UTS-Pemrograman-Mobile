import 'package:flutter/material.dart';

// Mengubah nama kelas menjadi DetailOven
class DetailOven extends StatelessWidget {
  const DetailOven({super.key});

  // Data statis untuk detail item Oven
  static const String namaMenu = "Panasonic Oven - NT-H900KSR";
  static const int priceValue = 625000;
  static const String hargaTetap = "Rp 625.000";
  static const String gambarPath = "assets/oven.jpg";

  static const List<Map<String, String>> specs = [
    {"label": "Type", "value": "Oven Toaster"},
    {"label": "Kapasitas", "value": "9 L"},
    {"label": "Catu Daya", "value": "230V ~ 50Hz"},
    {"label": "Pemakaian Daya", "value": "1000W - 918W"},
    {"label": "Pengaturan Suhu", "value": "70-230℃"},
    {"label": "Berat Bersih", "value": "± 3,1 kg"},
    {"label": "Ukuran Luar (LxDxT)", "value": "366 mm × 274 mm × 204 mm"},
    {"label": "Ruang Dalam (LxDxT)", "value": "269 mm × 202 mm × 169 mm"},
    {"label": "Garansi", "value": "Garansi Panasonic 1 Tahun"},
    {"label": "SKU", "value": "NT-H900KSR"},
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final TextStyle labelStyle = TextStyle(
      fontSize: 16,
      color: colorScheme.onSurfaceVariant,
    );
    final TextStyle valueStyle = TextStyle(
      fontSize: 16,
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: labelStyle)),
          Text(": ", style: labelStyle),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
              onPressed: () {
                _showSnackbar(context, "Berhasil Dibagikan!");
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // =============== KONTEN SCROLLABLE ===============
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
                        color: colorScheme.surfaceVariant,
                        alignment: Alignment.center,
                        child: Text(
                          "Gambar Oven tidak ditemukan",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
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

          // =============== TOMBOL FIXED BAWAH ===============
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
                          String message =
                              '$namaMenu (Harga: $totalHargaDisplay) ditambahkan ke keranjang!';
                          _showSnackbar(context, message);
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
