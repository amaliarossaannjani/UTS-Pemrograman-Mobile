import 'package:flutter/material.dart';

// Mengubah nama kelas menjadi DetailTV
class DetailTV extends StatelessWidget {
  const DetailTV({super.key});

  // Data statis untuk detail item TV (Sharp Kulkas diubah menjadi Samsung TV)
  static const String namaMenu =
      "Samsung LED Smart TV 50 Inch 4K Crystal UHD U8000F 2025 - 50U8000";
  static const int priceValue = 5050000;
  static const String hargaTetap = "Rp 5.050.000";
  static const String gambarPath = "assets/tv.jpg";

  // Spesifikasi TV
  static const List<Map<String, String>> specs = [
    {"label": "Ukuran Layar", "value": "50 inch"},
    {"label": "Resolusi", "value": "4K (3,840 x 2,160)"},
    {"label": "Operating System", "value": "Tizen™ Smart TV"},
    {"label": "Picture Engine", "value": "Crystal Processor 4K"},
    {"label": "HDR", "value": "HDR 10+ Support"},
    {"label": "Object Tracking Sound", "value": "OTS Lite"},
    {"label": "Speaker Type", "value": "2CH"},
    {"label": "Power Supply", "value": "AC100-240V~ 50/60Hz"},
    {"label": "Eco Sensor", "value": "Yes"},
    {"label": "Bixby", "value": "Yes"},
    {"label": "Auto Game Mode (ALLM)", "value": "Yes"},
    {"label": "HDMI Port", "value": "3"},
    {"label": "USB Port", "value": "1 x USB-A"},
    {"label": "Wi-Fi", "value": "Yes (Wi-Fi 5)"},
    {"label": "Bezel Type", "value": "3 Bezel-less"},
    {"label": "Dimensi (dengan penyangga)", "value": "1110.8 x 695.1 x 199 mm"},
    {"label": "Remote Controller Model", "value": "TM2240A"},
    {"label": "Garansi", "value": "Garansi Samsung 1 Tahun"},
    {"label": "SKU", "value": "50U8000"},
  ];

  static final Color _darkGreyColor = Colors.grey.shade700;

  String _formatPrice(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

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
          const Text(
            ": ",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Expanded(
            child: Text(value, style: valueStyle, textAlign: TextAlign.left),
          ),
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
          // 1. Konten Scrollable (Gambar + Detail)
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============== BAGIAN GAMBAR (DIPERBAIKI SESUAI KULKAS) ==============
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
                          "Gambar TV tidak ditemukan",
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

                      ...specs.map((spec) {
                        return _buildSpecRow(
                          context,
                          spec["label"]!,
                          spec["value"]!,
                        );
                      }).toList(),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Tombol Aksi (Fixed di bawah layar)
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
                      onPressed: () {
                        _showSnackbar(context, 'Disimpan ke Favorit!');
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: _darkGreyColor.withOpacity(0.5),
                          width: 1.5,
                        ),
                        padding: EdgeInsets.zero,
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
                          "Tambahkan (${totalHargaDisplay})",
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
