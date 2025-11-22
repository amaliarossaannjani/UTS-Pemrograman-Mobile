import 'package:flutter/material.dart';

// Mengubah menjadi StatelessWidget karena tidak ada lagi state quantity/note yang dinamis
class DetailKulkas extends StatelessWidget {
  const DetailKulkas({super.key});

  // Data statis untuk detail item Kulkas
  static const String namaMenu =
      "Sharp Kulkas Side By Side 608 L - SJ-X65WB SL";
  static const int priceValue = 17050000; // Harga sebagai int
  static const String hargaTetap =
      "Rp 17.050.000"; // Menggunakan titik sebagai pemisah ribuan
  static const String gambarPath = "assets/kulkas.jpg";

  // Spesifikasi Kulkas dirangkum dalam deskripsi (Disederhanakan untuk pemrosesan)
  static const List<Map<String, String>> specs = [
    {"label": "Kapasitas", "value": "577 L (Freezer: 179 L; Lemari Es: 359 L)"},
    {"label": "Sistem Pendinginan", "value": "Fan Cooling System"},
    {"label": "Defrost System", "value": "Automatic"},
    {"label": "Dispenser", "value": "Ice and Water"},
    {"label": "Daya Listrik", "value": "173 W (220-240 V)"},
    {"label": "Warna Tersedia", "value": "Silver"},
    {"label": "Dimensi (W×H×D)", "value": "906 x 1770 x 735 mm"},
    {"label": "Berat", "value": "98 Kg"},
    {"label": "Garansi", "value": "Garansi Sharp 1 Tahun"},
    {"label": "SKU", "value": "SJ-X65WB SL"},
  ];

  // --- DEFINISI WARNA UNTUK KESELARASAN (Abu-abu Gelap) ---
  static final Color _darkGreyColor = Colors.grey.shade700; // Abu-abu gelap

  // Fungsi utilitas untuk memformat harga
  String _formatPrice(int price) {
    // Fungsi ini tidak terpakai jika menggunakan hargaTetap yang sudah diformat
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Fungsi untuk menampilkan SnackBar yang adaptif
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

  // Widget untuk menampilkan satu baris spesifikasi dengan alignment yang rapi (DIPERBAIKI)
  Widget _buildSpecRow(BuildContext context, String label, String value) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // PERBAIKAN: Menggunakan warna tematik agar support dark/light mode
    final TextStyle labelStyle = TextStyle(
      fontSize: 16,
      color: colorScheme
          .onSurfaceVariant, // Warna redup yang adaptif (putih keabu-abuan di Dark Mode)
    );
    final TextStyle valueStyle = TextStyle(
      fontSize: 16,
      color: colorScheme
          .onSurface, // Warna tegas yang adaptif (putih penuh di Dark Mode)
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom Kiri: Label (e.g., Kapasitas)
          SizedBox(
            width:
                140, // Lebar tetap untuk label, memastikan kolom kanan sejajar
            child: Text(label, style: labelStyle),
          ),
          // PERBAIKAN: Menggunakan labelStyle untuk tanda ":" agar adaptif
          Text(": ", style: labelStyle), // Titik dua
          // Kolom Kanan: Value (e.g., 577 L...)
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
                          "Gambar Kulkas tidak ditemukan",
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
                      // Judul Menu
                      Text(
                        namaMenu,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Harga
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

                      // Judul Deskripsi
                      Text(
                        "Deskripsi & Spesifikasi:",
                        style: TextStyle(
                          fontSize:
                              18, // Ukuran font sedikit dibesarkan untuk penekanan
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ============== SPESIFIKASI YANG TELAH DIRAPIKAN ==============
                      ...specs.map((spec) {
                        return _buildSpecRow(
                          context,
                          spec["label"]!,
                          spec["value"]!,
                        );
                      }).toList(),
                      // ==========================================================

                      // Memberi ruang agar konten tidak tertutup fixed button di bawah
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Tombol Aksi (Fixed di Bawah Layar)
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
                  // Tombol Simpan (Menggunakan abu-abu gelap)
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

                  // Tombol Add to Cart (Memanjang)
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Pesan SnackBar
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
                          // Menampilkan Harga Tetap pada Tombol
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
