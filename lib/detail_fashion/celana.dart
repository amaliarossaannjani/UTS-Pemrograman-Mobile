import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state jumlah item dan ukuran
class DetailCelana extends StatefulWidget {
  const DetailCelana({super.key});

  @override
  State<DetailCelana> createState() => _DetailCelanaState();
}

class _DetailCelanaState extends State<DetailCelana> {
  // State untuk menyimpan jumlah item yang dipilih (default 1)
  int _quantity = 1;

  // State untuk menyimpan ukuran (pinggang) yang dipilih
  String? _selectedSize;

  // State untuk menyimpan warna yang dipilih
  String? _selectedColor;

  // Data produk
  static const String namaMenu = "Marks & Spencer - Skinny Fit Stretch Chinos";
  static const int priceValue = 479920;
  static const String hargaTetap = "Rp 479.920";

  // Gambar (hanya ini yang diperbaiki style-nya)
  static const String gambarPath = "assets/celana.jpg";

  // Daftar ukuran
  final List<String> _availableSizes = [
    'W28',
    'W30',
    'W32',
    'W34',
    'W36',
    'W38',
  ];

  // Daftar warna
  final List<String> _availableColors = [
    'Dark Navy',
    'Black',
    'Cream',
    'Brown',
  ];

  static const String deskripsi = """
Bahan & Perawatan :
• Bahan: 98% katun, 2% elastane (Stretchable)
• Perawatan: Cuci 40°C, Jangan pemutih, Keringkan suhu sedang, Setrika suhu sedang, Jangan di dry clean

Rincian :
• SKU: 5D487AA08D44C5GS
• Warna: Dark Navy (Tersedia juga Black, Cream, Brown)
• Motif: Solid
• Panjang: Panjang
• Gaya: Basic

Tentang Produk :
- Celana chino untuk smart casual look yang nyaman
- Mid rise
- Unlined
- Skinny fit
- Kancing dan resleting depan
- 2 kantong samping
- Material katun kombinasi tidak transparan, ringan dan stretchable
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

  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final bool isActive = onPressed != null;

    final Color finalButtonColor = isActive
        ? (icon == Icons.add ? _darkGreyColor : colorScheme.primary)
        : colorScheme.surfaceVariant;

    final Color finalIconColor = isActive
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

  Widget _buildSizeSelector() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Ukuran Pinggang:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _availableSizes.map((size) {
            final isSelected = _selectedSize == size;
            return ChoiceChip(
              label: Text(size),
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

  Widget _buildColorSelector() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Warna:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _availableColors.map((color) {
            final isSelected = _selectedColor == color;
            return ChoiceChip(
              label: Text(color),
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
                setState(() {
                  _selectedColor = selected ? color : null;
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== GAMBAR =====
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
                          "Gambar Celana tidak ditemukan",
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      );
                    },
                  ),
                ),

                // ===== DETAIL =====
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

                      Text(
                        hargaTetap,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const Divider(height: 32),

                      Text(
                        "Detail Produk:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        deskripsi,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const Divider(height: 32),

                      _buildColorSelector(),
                      _buildSizeSelector(),

                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== BOTTOM ACTION BAR =====
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
                  // Qty
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jumlah Item:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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

                  // Buttons
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            _showSnackbar(context, "Disimpan ke Favorit!");
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: _darkGreyColor.withOpacity(0.5),
                              width: 1.5,
                            ),
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
                              if (_selectedColor == null) {
                                _showSnackbar(
                                  context,
                                  "Mohon pilih warna terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }
                              if (_selectedSize == null) {
                                _showSnackbar(
                                  context,
                                  "Mohon pilih ukuran pinggang terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }

                              String m =
                                  "$_quantity item $namaMenu (Warna: $_selectedColor, Ukuran: $_selectedSize, Total: $totalHargaDisplay) ditambahkan ke keranjang!";
                              _showSnackbar(context, m);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Tambahkan ($totalHargaDisplay)",
                              style: TextStyle(
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
