import 'package:flutter/material.dart';

class Jawaban extends StatelessWidget {
  const Jawaban({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> widgetList = [
      {
        "name": "1. MaterialApp",
        "desc":
            "Sebagai root utama aplikasi Flutter. Mengatur tema, navigasi, dan halaman awal (home).",
      },
      {
        "name": "2. Scaffold",
        "desc": "Memberikan struktur dasar halaman seperti AppBar dan body.",
      },
      {
        "name": "3. AppBar",
        "desc":
            "Menampilkan judul halaman seperti 'MyShop Mini' atau nama kategori.",
      },
      {
        "name": "4. Column",
        "desc":
            "Mengatur elemen UI secara vertikal (misalnya: judul + daftar kategori).",
      },
      {
        "name": "5. Row",
        "desc": "Mengatur elemen UI secara horizontal, seperti Card kategori.",
      },
      {
        "name": "6. Card",
        "desc": "Membungkus konten kategori atau produk dalam bentuk kotak.",
      },
      {
        "name": "7. InkWell / GestureDetector",
        "desc":
            "Supaya Card dapat ditekan (onTap) untuk navigasi antar halaman.",
      },
      {
        "name": "8. Icon",
        "desc":
            "Menampilkan ikon kategori atau ikon produk di ProductDetailScreen.",
      },
      {
        "name": "9. Text",
        "desc":
            "Menampilkan teks seperti nama kategori, nama produk, dan harga.",
      },
      {
        "name": "10. GridView.count",
        "desc": "Menampilkan daftar produk dalam bentuk grid 2 kolom.",
      },
      {
        "name": "11. Navigator.push",
        "desc": "Untuk pindah halaman (Home → ProductList → ProductDetail).",
      },
      {
        "name": "12. Navigator.pop",
        "desc": "Untuk kembali ke halaman sebelumnya.",
      },
      {
        "name": "13. Expanded",
        "desc": "Agar GridView mengisi ruang yang tersisa dalam Column.",
      },
      {
        "name": "14. Padding / SizedBox",
        "desc": "Memberikan jarak antar-elemen agar tidak menempel.",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Widget & Fungsinya")),
      body: ListView.builder(
        itemCount: widgetList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                title: Text(
                  widgetList[index]["name"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widgetList[index]["desc"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}
