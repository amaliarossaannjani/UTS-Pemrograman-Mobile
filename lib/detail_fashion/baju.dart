import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state jumlah item dan ukuran
class DetailBaju extends StatefulWidget {
  const DetailBaju({super.key});

  @override
  State<DetailBaju> createState() => _DetailBajuState();
}

class _DetailBajuState extends State<DetailBaju> {
  // State untuk menyimpan jumlah item yang dipilih (default 1)
  int _quantity = 1;

  // State untuk menyimpan ukuran yang dipilih (default kosong)
  String? _selectedSize;

  // Data produk baju Shirt
  static const String namaMenu = "Polo Shirt – Union Polo Brown";
  static const int priceValue = 115000; // Harga sebagai int: 115.000
  static const String hargaTetap = "Rp 115.000";
  static const String gambarPath = "assets/baju.jpg"; // Path gambar baru

  final List<String> _availableSizes = ['M', 'L', 'XL', '2XL', '3XL', '4XL'];

  // Deskripsi lengkap dari data yang diberikan
  static const String deskripsi = """
Fitur Utama :
• Bahan: Cvc Pique (Lembut & Nyaman)
• Desain: Simpel dan Elegan
• Warna: Brown (Mudah dipadukan)

Detail Ukuran :
• M: Chest: 52 cm | Length: 66 cm | Sleeve: 20 cm
• L: Chest: 55 cm | Length: 70 cm | Sleeve: 22 cm
• XL: Chest: 58 cm | Length: 72 cm | Sleeve: 23 cm
• 2XL: Chest: 60 cm | Length: 74 cm | Sleeve: 24 cm
• 3XL: Chest: 67 cm | Length: 79 cm | Sleeve: 26 cm
• 4XL: Chest: 70 cm | Length: 81 cm | Sleeve: 27 cm

Penggunaan :
Sangat cocok untuk aktivitas sehari-hari, bersantai di rumah, hangout, maupun kegiatan outdoor ringan.

Notes Penting :
1. Warna pada gambar mungkin tidak 100% sama (faktor cahaya).
2. Selisih 1-2 Cm mungkin terjadi (proses produksi).
3. Diwajibkan video unboxing untuk komplain/penukaran.
4. Pastikan alamat lengkap & No Hp aktif.
5. Setiap pembelian Free Sticker.
""";

  // --- DEFINISI WARNA BARU UNTUK KESELARASAN (Abu-abu Gelap) ---
  static final Color _darkGreyColor = Colors.grey.shade700; // Abu-abu gelap
  static final Color _onDarkGreyColor =
      Colors.white; // Warna ikon di atas abu-abu gelap

  // Fungsi utilitas untuk memformat harga
  String _formatPrice(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Fungsi untuk menampilkan SnackBar yang adaptif (menyesuaikan gaya Ayam Geprek)
  void _showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false, // Tetap gunakan isError untuk validasi
  }) {
    if (!mounted) return;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Menggunakan warna container yang berbeda untuk error
    final Color backgroundColor = isError
        ? colorScheme.errorContainer
        : colorScheme.secondaryContainer;
    final Color contentColor = isError
        ? colorScheme.onErrorContainer
        : colorScheme.onSecondaryContainer;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(color: contentColor, fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Widget helper untuk tombol tambah/kurang kuantitas
  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final bool isActive = onPressed != null;

    // Tombol Tambah (+) harus abu-abu gelap
    // Tombol Kurang (-) harus mengikuti skema warna tema (primary/biru di Material 3)
    final Color finalButtonColor = isActive
        ? (icon == Icons.add ? _darkGreyColor : colorScheme.primary)
        : colorScheme.surfaceVariant; // Nonaktif

    final Color finalIconColor = isActive
        ? (icon == Icons.add ? _onDarkGreyColor : colorScheme.onPrimary)
        : colorScheme.onSurfaceVariant; // Nonaktif

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: finalButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: finalIconColor),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  // Widget helper untuk memilih ukuran
  Widget _buildSizeSelector() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Ukuran:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10.0, // Jarak horizontal antar chip
          runSpacing: 10.0, // Jarak vertikal antar baris
          children: _availableSizes.map((size) {
            final isSelected = _selectedSize == size;
            return ChoiceChip(
              label: Text(size),
              selected: isSelected,
              selectedColor:
                  colorScheme.primary, // Warna saat dipilih (biru tema)
              backgroundColor: colorScheme.surfaceVariant, // Warna default
              labelStyle: TextStyle(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                ),
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedSize = selected ? size : null;
                });
              },
            );
          }).toList(),
        ),
        const Divider(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Menghitung total harga
    int totalPrice = _quantity * priceValue;
    String totalHargaDisplay = _formatPrice(totalPrice);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          namaMenu,
          style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
        ),
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
                          "Gambar Pakaian tidak ditemukan",
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
                          fontSize: 22, // Disesuaikan dengan Ayam Geprek
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Harga (Menggunakan colorScheme.primary seperti Ayam Geprek)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            hargaTetap,
                            style: TextStyle(
                              fontSize: 24, // Disesuaikan dengan Ayam Geprek
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary, // WARNA TEMA/BIRU
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),

                      // Deskripsi
                      Text(
                        "Detail Produk:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        deskripsi,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const Divider(height: 32),

                      // ============== BAGIAN PEMILIHAN UKURAN ==============
                      _buildSizeSelector(),

                      // Jarak tambahan agar konten tidak tertutup fixed bottom bar
                      const SizedBox(height: 150),
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
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Agar Column hanya selebar isinya
                children: [
                  // ============== Quantity Selector ==============
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jumlah Item:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Row(
                        children: [
                          // Tombol Kurangi
                          _buildQuantityButton(
                            context,
                            icon: Icons.remove,
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '$_quantity',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),

                          // Tombol Tambah (Menggunakan abu-abu gelap)
                          _buildQuantityButton(
                            context,
                            icon: Icons.add,
                            // Batas maksimum 100
                            onPressed: _quantity < 100
                                ? () => setState(() => _quantity++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Spacer
                  // ============== Action Buttons (Simpan & Tambahkan) ==============
                  Row(
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
                          child: Icon(
                            Icons.bookmark_border,
                            color: _darkGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Tombol Tambahkan (Memanjang)
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedSize == null) {
                                // Menggunakan isError: true agar warna SnackBar berbeda
                                _showSnackbar(
                                  context,
                                  "Mohon pilih ukuran kaos terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }

                              String message =
                                  '$_quantity item $namaMenu (Ukuran: $_selectedSize, Total: $totalHargaDisplay) ditambahkan ke keranjang!';
                              _showSnackbar(context, message);

                              // Opsional: Reset state setelah ditambahkan
                              // setState(() {
                              //   _quantity = 1;
                              //   _selectedSize = null;
                              // });
                            },
                            style: ElevatedButton.styleFrom(
                              // Menggunakan warna hijau sesuai contoh Ayam Geprek
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              // Menampilkan Harga Total pada Tombol
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
