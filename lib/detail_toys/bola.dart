import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state jumlah item dan varian
// Nama kelas: DetailBola
class DetailBola extends StatefulWidget {
  const DetailBola({super.key});

  @override
  State<DetailBola> createState() => _DetailBolaState();
}

class _DetailBolaState extends State<DetailBola> {
  // State untuk menyimpan jumlah item yang dipilih (default 1)
  int _quantity = 1;

  // State untuk menyimpan varian yang dipilih (default kosong)
  String? _selectedVariant;

  // --- DATA PRODUK BOLA FUTSAL FUTBOL ---
  static const String namaMenu =
      "FUTBOL Bola Futsal Soccer Ball Bola Sepak Karet Bulat";
  static const int priceValue = 49000; // Harga sebagai int: 49.000
  static const String hargaTetap =
      "Rp 49.000"; // Digunakan untuk tampilan harga satuan
  static const String gambarPath = "assets/bola.jpg"; // Placeholder gambar

  // Daftar Varian Bola yang tersedia
  final List<String> _availableVariants = [
    'Futbol D: 25,5cm (Hitam Putih)',
    'Futbol D: 27,5cm (Hitam Putih)',
    'WARNA RANDOM',
  ];

  // Deskripsi lengkap dari data bola
  static const String deskripsi = """
FUTBOL Bola Futsal Soccer Ball Bola Sepak Karet Bulat
Kode produk : FUTBOL

Dimensi Produk :
• Ukuran: 10x10x10 cm
• Berat: 200 gram
• Kode SKU: KED-70077-00563

Detail Produk :
• Bola Karet, Berbentuk bulat sempurna.
• Cocok untuk bermain futsal/sepak bola mini.

Varian Tersedia :
1. Futbol Diameter: 25,5 cm (kempes 22cm)
2. Futbol New Diameter: 27,5cm (kempes 24cm)
PILIH VARIAN FAVORITMU: HITAM PUTIH atau WARNA RANDOM

Catatan Penting :
SEBELUM KIRIM, PRODUK AKAN KAMI TEST SATU PER SATU Terlebih Dahulu.
No Garansi / No Retur / No Complain
BELI = ATC = SETUJU = TELAH MEMBACA KETENTUAN DIATAS = NO KOMPLAIN
""";

  // --- DEFINISI WARNA BARU UNTUK KESELARASAN (Abu-abu Gelap) ---
  static final Color _darkGreyColor = Colors.grey.shade700; // Abu-abu gelap
  static final Color _onDarkGreyColor =
      Colors.white; // Warna ikon di atas abu-abu gelap

  // Fungsi utilitas untuk memformat harga
  String _formatPrice(int price) {
    // Fungsi ini memformat harga menjadi mata uang Rupiah (misal: 49.000)
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Fungsi untuk menampilkan SnackBar yang adaptif
  void _showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (!mounted) return;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

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

  // Widget helper untuk memilih varian (sebelumnya: memilih ukuran)
  Widget _buildVariantSelector() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Varian:", // Diubah menjadi Varian
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
          children: _availableVariants.map((variant) {
            final isSelected = _selectedVariant == variant;
            return ChoiceChip(
              label: Text(variant),
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
                  _selectedVariant = selected ? variant : null;
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
          namaMenu, // Nama produk
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
                _showSnackbar(context, "Informasi produk berhasil dibagikan!");
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
                          "Gambar Bola tidak ditemukan (Pastikan file assets/bola.jpg tersedia)", // Pesan yang lebih informatif
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
                          fontSize: 22, // Disesuaikan dengan DetailBaju
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
                              fontSize: 24, // Disesuaikan dengan DetailBaju
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary, // Warna Tema/Biru
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
                      // Menggunakan Text
                      Text(
                        deskripsi,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const Divider(height: 32),

                      // ============== BAGIAN PEMILIHAN VARIAN ==============
                      _buildVariantSelector(), // Memanggil widget pemilihan varian
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
                              // Validasi untuk varian (sebelumnya: ukuran)
                              if (_selectedVariant == null) {
                                _showSnackbar(
                                  context,
                                  "Mohon pilih varian bola terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }

                              String message =
                                  '$_quantity item $namaMenu (Varian: $_selectedVariant, Total: $totalHargaDisplay) ditambahkan ke keranjang!';
                              _showSnackbar(context, message);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .green
                                  .shade600, // Tetap hijau untuk "Tambahkan"
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
