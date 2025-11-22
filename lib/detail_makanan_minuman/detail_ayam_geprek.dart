import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state jumlah item dan catatan
class DetailAyamGeprek extends StatefulWidget {
  const DetailAyamGeprek({super.key});

  @override
  State<DetailAyamGeprek> createState() => _DetailAyamGeprekState();
}

class _DetailAyamGeprekState extends State<DetailAyamGeprek> {
  // State untuk menyimpan jumlah item yang dipilih (default 1)
  int _quantity = 1;

  // State untuk menyimpan teks catatan dari pelanggan (default kosong)
  String _note = '';

  // Controller untuk mengelola input teks catatan
  final TextEditingController _noteController = TextEditingController();

  // Data dummy untuk detail item ini
  static const String namaMenu = "Ayam Geprek Sambal Bawang";
  static const String deskripsi =
      "Nasi + Ayam Krispi + Lalapan + Sambal Bawang (level 1-5)";
  static const int priceValue = 18000; // Harga sebagai int
  static const String hargaTetap = "Rp 18.000";
  static const String gambarPath = "assets/ayam_geprek.jpg";

  // --- DEFINISI WARNA BARU UNTUK KESELARASAN (Abu-abu Gelap) ---
  static final Color _darkGreyColor = Colors.grey.shade700; // Abu-abu gelap
  static final Color _onDarkGreyColor =
      Colors.white; // Warna ikon di atas abu-abu gelap

  @override
  void initState() {
    super.initState();
    // Mendengarkan perubahan pada controller dan memperbarui state _note
    _noteController.addListener(() {
      setState(() {
        _note = _noteController.text;
      });
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Fungsi utilitas untuk memformat harga
  String _formatPrice(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Fungsi untuk menampilkan SnackBar yang adaptif
  void _showSnackbar(BuildContext context, String message) {
    if (!mounted) return;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Secara eksplisit sembunyikan SnackBar yang sedang tampil
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
        duration: const Duration(
          seconds: 4,
        ), // Durasi sedikit diperpanjang agar pesan catatan terbaca
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Menghitung total harga
    int totalPrice = _quantity * priceValue;
    String totalHargaDisplay = _formatPrice(totalPrice);

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
                          "Gambar Ayam Geprek tidak ditemukan",
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

                      // Deskripsi
                      Text(
                        "Deskripsi:",
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

                      // ============== BAGIAN CATATAN PESANAN ==============
                      Text(
                        "Catatan Tambahan (Opsional):",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Tambahkan Catatan",
                          hintStyle: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: colorScheme.outline),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          fillColor: colorScheme.surfaceVariant.withOpacity(
                            0.5,
                          ),
                          filled: true,
                        ),
                        style: TextStyle(color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 200),
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
                            onPressed: _quantity < 100
                                ? () => setState(() => _quantity++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Spacer
                  // ============== Action Buttons (Simpan & Add to Cart) ==============
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
                            // --- PERUBAHAN DI SINI (Warna Garis Border) ---
                            side: BorderSide(
                              color: _darkGreyColor.withOpacity(0.5),
                              width: 1.5,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Icon(
                            Icons.bookmark_border,
                            // --- PERUBAHAN DI SINI (Warna Ikon Favorit) ---
                            color: _darkGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Tombol Add to Cart (Memanjang)
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Siapkan pesan SnackBar, tambahkan catatan jika tidak kosong
                              String message =
                                  '$_quantity item $namaMenu (Total: $totalHargaDisplay) ditambahkan ke keranjang!';
                              if (_note.trim().isNotEmpty) {
                                message += '\nCatatan: "${_note.trim()}"';
                              } else {
                                message += '\n(Tidak ada catatan tambahan)';
                              }
                              _showSnackbar(context, message);

                              // PENTING: Clear field setelah ditambahkan (opsional, tergantung UX)
                              // _noteController.clear();
                              // setState(() { _quantity = 1; });
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
