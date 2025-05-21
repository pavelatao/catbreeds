import 'package:catbreeds/modules/home/domain/models/cat.dart';
import 'package:flutter/material.dart';

class CatDetailPage extends StatelessWidget {
  final Cat cat;

  const CatDetailPage({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final breed = cat.breeds?.isNotEmpty == true ? cat.breeds![0] : null;

    return Scaffold(
      appBar: AppBar(leading: BackButton(), title: Text(breed?.name ?? 'Detalle'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen fija
            cat.url != null
                ? Image.network(cat.url!, width: double.infinity, fit: BoxFit.cover)
                : const SizedBox(height: 250, child: Center(child: Text('Sin imagen'))),

            // Scroll solo para los datos
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(breed?.description ?? 'Sin descripción.', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text("Origen: ${breed?.origin ?? 'Desconocido'}", style: const TextStyle(fontSize: 18)),
                    Text("Vida promedio: ${breed?.lifeSpan ?? 'N/A'} años", style: const TextStyle(fontSize: 18)),
                    Text("Adaptabilidad: ${breed?.adaptability?.toString() ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                    Text("Afecto hacia humanos: ${breed?.affectionLevel?.toString() ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                    Text("Inteligencia: ${breed?.intelligence?.toString() ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                    Text("Energía: ${breed?.energyLevel?.toString() ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                    Text("Temperamento: ${breed?.temperament?.toString() ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
