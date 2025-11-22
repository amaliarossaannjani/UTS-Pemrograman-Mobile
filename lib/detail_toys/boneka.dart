import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state jumlah item dan varian
class DetailBoneka extends StatefulWidget {
  const DetailBoneka({super.key});

  @override
  State<DetailBoneka> createState() => _DetailBonekaState();
}

class _DetailBonekaState extends State<DetailBoneka> {
  int _quantity = 1;
  String? _selectedVariant;

  static const String namaMenu =
      "MINISO Boneka Seri TOY Story Lotso Bear Strawberry Plush Toy Boneka Lucu Mainan Boneka Kado Ulang Tahun";
  static const int priceValue = 132900;
  static const String hargaTetap = "Rp 132.900";
  static const String gambarPath = "assets/boneka.jpg";

  final List<String> _availableVariants = [
    'Ukuran: 25 cm (S)',
    'Ukuran: 40 cm (M)',
    'Ukuran: 60 cm (L)',
  ];

  static const String deskripsi = """
MINISO Boneka Seri TOY Story Lotso Bear Strawberry Plush Toy Boneka Lucu Mainan Boneka Kado Ulang Tahun
Kode SKU : MII-60035-03850

Fitur :
• Nyaman dengan kualitas kain yang bagus.
• Ide bagus untuk hadiah ulang tahun/hadiah valentine.
• Bahan: 100% serat poliester

Detail Dimensi Produk (untuk ukuran S) :
• Ukuran: Strawberry Lotso: 25x16 cm

Varian Tersedia :
PILIH VARIAN UKURAN: S (25cm), M (40cm), atau L (60cm).

Catatan Penting :
SEBELUM KIRIM, PRODUK AKAN KAMI TEST SATU PER SATU Terlebih Dahulu.
No Garansi / No Retur / No Complain
BELI = ATC = SETUJU = TELAH MEMBACA KETENTUAN DIATAS = NO KOMPLAIN
""";

  static final Color _darkGreyColor = Colors.grey.shade700;
  static final Color _onDarkGreyColor = Colors.white;

  String _formatPrice(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void _showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (!mounted) return;
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final backgroundColor = isError
        ? colorScheme.errorContainer
        : colorScheme.secondaryContainer;
    final contentColor = isError
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

  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = onPressed != null;

    final finalButtonColor = isActive
        ? (icon == Icons.add ? _darkGreyColor : colorScheme.primary)
        : colorScheme.surfaceVariant;

    final finalIconColor = isActive
        ? (icon == Icons.add ? _onDarkGreyColor : colorScheme.onPrimary)
        : colorScheme.onSurfaceVariant;

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

  Widget _buildVariantSelector() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Varian:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _availableVariants.map((variant) {
            final isSelected = _selectedVariant == variant;
            return ChoiceChip(
              label: Text(variant),
              selected: isSelected,
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceVariant,
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
                setState(() => _selectedVariant = selected ? variant : null);
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
    final colorScheme = Theme.of(context).colorScheme;

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
            padding: const EdgeInsets.only(right: 12),
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============== BAGIAN GAMBAR DARI BOLA (DITERAPKAN DI SINI) ==============
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
                          "Gambar Boneka tidak ditemukan (Pastikan file assets/boneka.jpg tersedia)",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      );
                    },
                  ),
                ),

                // ============== DETAIL PRODUK (TIDAK DIUBAH) ==============
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

                      _buildVariantSelector(),

                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ============== BOTTOM BAR (TIDAK DIUBAH) ==============
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
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  const SizedBox(height: 16),

                  Row(
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
                          child: Icon(
                            Icons.bookmark_border,
                            color: _darkGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedVariant == null) {
                                _showSnackbar(
                                  context,
                                  "Mohon pilih varian terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }

                              String message =
                                  '$_quantity item $namaMenu (Varian: $_selectedVariant, Total: $totalHargaDisplay) ditambahkan ke keranjang!';
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
