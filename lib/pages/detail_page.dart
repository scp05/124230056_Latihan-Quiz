import 'package:flutter/material.dart';
import 'package:tugas_kendaraan/data/vehicle_data.dart';

class DetailPage extends StatefulWidget {
  final Vehicle vehicle;

  const DetailPage({super.key, required this.vehicle});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String selectedImageUrl;

  @override
  void initState() {
    super.initState();
    selectedImageUrl = widget.vehicle.imageUrls.isNotEmpty
        ? widget.vehicle.imageUrls[0]
        : 'https://via.placeholder.com/400x300.png?text=No+Image';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0D47A1);
    final textColor = Colors.grey[800];
    final priceColor = Colors.green[700];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.vehicle.name,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.network(
                    selectedImageUrl,
                    key: ValueKey<String>(selectedImageUrl),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                scrollDirection: Axis.horizontal,
                itemCount: widget.vehicle.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.vehicle.imageUrls[index];
                  final isSelected = imageUrl == selectedImageUrl;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImageUrl = imageUrl;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color:
                              isSelected ? primaryColor : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrl,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vehicle.name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tipe: ${widget.vehicle.type}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.vehicle.price,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: priceColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(
                color: Colors.grey[200],
                thickness: 1,
                indent: 16,
                endIndent: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.vehicle.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15, color: Colors.grey[700], height: 1.5),
                  ),
                ],
              ),
            ),
            Divider(
                color: Colors.grey[200],
                thickness: 1,
                indent: 16,
                endIndent: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spesifikasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSpecificationRow(
                      Icons.settings, 'Mesin', widget.vehicle.engine),
                  const SizedBox(height: 8),
                  _buildSpecificationRow(Icons.local_gas_station,
                      'Bahan Bakar', widget.vehicle.fuelType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}