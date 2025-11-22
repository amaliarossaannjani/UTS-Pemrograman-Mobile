// === DETAIL JAKET (HANYA BAGIAN GAMBAR YANG DIPERBAIKI) ===

import 'package:flutter/material.dart';

class DetailJaket extends StatefulWidget {
  const DetailJaket({super.key});

  @override
  State<DetailJaket> createState() => _DetailJaketState();
}

class _DetailJaketState extends State<DetailJaket> {
  int _quantity = 1;
  String? _selectedSize;
  String? _selectedColor;

  static const String namaMenu = "Levi's® Men's Type II Trucker Jacket";
  static const int priceValue = 1799900;
  static const String gambarPath = "assets/jaket.jpg";

  final List<String> _availableSizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _availableColors = [
    'Blue Sky Selv',
    'Indigo',
    'Black',
    'Rinsed',
  ];

  static const String deskripsi = """
Levi's® Men's Type II Trucker Jacket menghadirkan desain klasik yang terinspirasi dari arsip Levi’s® dengan sentuhan modern. Jaket ini mempertahankan detail ikonik seperti lipatan depan dan saku kancing, namun dengan potongan yang lebih santai untuk kenyamanan ekstra. Cocok dipadukan dengan berbagai gaya, menjadikannya pilihan timeless untuk melengkapi tampilan kasual maupun edgy.

Rincian :
• Style: a7632
• PC9 #: a76320014
• Warna: Blue Sky Selv
• Panjang: Pinggang
• Gaya: Basic / Trucker

How it Fits :
• Potongan nyaman
• Kerah runcing
• Lengan panjang
• Model is wearing size medium
• Tinggi Badan Model 185cm

Composition & Care :
• Bahan: 100% Katun
• Perawatan: Ikuti petunjuk label.
""";

  static final Color _primaryGreen = Colors.green.shade700;
  static final Color _onPrimaryGreen = Colors.white;

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
    final cs = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? cs.errorContainer : cs.secondaryContainer,
        content: Text(
          message,
          style: TextStyle(
            color: isError ? cs.onErrorContainer : cs.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
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
    final cs = Theme.of(context).colorScheme;
    final bool isActive = onPressed != null;

    final Color finalButtonColor = isActive
        ? (icon == Icons.add ? _darkGreyColor : cs.primary)
        : cs.surfaceVariant;

    final Color finalIconColor = isActive
        ? (icon == Icons.add ? _onDarkGreyColor : cs.onPrimary)
        : cs.onSurfaceVariant;

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
        splashRadius: 20,
      ),
    );
  }

  Widget _buildAttributeSelector({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String?) onSelected,
  }) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((value) {
            final isSelected = selectedValue == value;
            return ChoiceChip(
              label: Text(value),
              selected: isSelected,
              selectedColor: cs.primary,
              backgroundColor: cs.surfaceVariant,
              labelStyle: TextStyle(
                color: isSelected ? cs.onPrimary : cs.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? cs.primary : cs.outline),
              ),
              onSelected: (selected) => onSelected(selected ? value : null),
            );
          }).toList(),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildDescription() {
    final cs = Theme.of(context).colorScheme;
    final List<TextSpan> spans = [];
    final lines = deskripsi.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      final boldRegex = RegExp(r'\*\*(.*?)\*\*');
      int pos = 0;

      for (final match in boldRegex.allMatches(line)) {
        if (match.start > pos) {
          spans.add(TextSpan(text: line.substring(pos, match.start)));
        }
        spans.add(
          TextSpan(
            text: match.group(1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
        pos = match.end;
      }

      if (pos < line.length) {
        spans.add(TextSpan(text: line.substring(pos)));
      }
      spans.add(const TextSpan(text: '\n'));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, height: 1.5, color: cs.onSurface),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    int totalPrice = _quantity * priceValue;
    String totalHargaDisplay = _formatPrice(totalPrice);
    String hargaSatuanDisplay = _formatPrice(priceValue);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          namaMenu,
          style: TextStyle(color: cs.onSurface, fontSize: 16),
        ),
        backgroundColor: cs.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.onSurface),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Icons.share, color: cs.onSurface),
              onPressed: () => _showSnackbar(
                context,
                "Informasi produk berhasil dibagikan!",
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ======================================================
          // ========== BAGIAN GAMBAR — SUDAH DIPERBAIKI ==========
          // ======================================================
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: cs.surfaceVariant,
                  child: Image.asset(
                    gambarPath,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 400,
                        alignment: Alignment.center,
                        color: cs.surfaceVariant,
                        child: Text(
                          "Gambar Jaket tidak ditemukan",
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      );
                    },
                  ),
                ),

                // ======================================================
                // ========== SELURUH KODE DI BAWAH TIDAK DIUBAH =========
                // ======================================================
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
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            hargaSatuanDisplay,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: cs.primary,
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
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDescription(),
                      const Divider(height: 32),

                      _buildAttributeSelector(
                        title: "Pilih Warna",
                        options: _availableColors,
                        selectedValue: _selectedColor,
                        onSelected: (v) => setState(() => _selectedColor = v),
                      ),
                      _buildAttributeSelector(
                        title: "Pilih Ukuran",
                        options: _availableSizes,
                        selectedValue: _selectedSize,
                        onSelected: (v) => setState(() => _selectedSize = v),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
                color: cs.surface,
                boxShadow: [
                  BoxShadow(
                    color: cs.onSurface.withOpacity(
                      cs.brightness == Brightness.dark ? 0.2 : 0.1,
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
                          color: cs.onSurface,
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
                              "$_quantity",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurface,
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
                          onPressed: () =>
                              _showSnackbar(context, 'Disimpan ke Favorit!'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
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
                              if (_selectedColor == null ||
                                  _selectedSize == null) {
                                _showSnackbar(
                                  context,
                                  "Mohon pilih ukuran dan warna jaket terlebih dahulu.",
                                  isError: true,
                                );
                                return;
                              }

                              _showSnackbar(
                                context,
                                '$_quantity item $namaMenu (Warna: $_selectedColor, Ukuran: $_selectedSize, Total: $totalHargaDisplay) ditambahkan ke keranjang!',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryGreen,
                              foregroundColor: _onPrimaryGreen,
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
