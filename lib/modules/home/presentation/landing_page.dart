import 'dart:async';

import 'package:catbreeds/modules/home/application/home/cat_bloc.dart';
import 'package:catbreeds/modules/home/presentation/cat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(CatFetchRequested());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final breedId = value.trim().toLowerCase();
      if (breedId.isEmpty) {
        context.read<CatBloc>().add(CatFetchRequested());
      } else {
        context.read<CatBloc>().add(CatFetchRequested(breedId: breedId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catbreeds'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Buscar raza en inglés...', suffixIcon: Icon(Icons.search), border: OutlineInputBorder()),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<CatBloc, CatState>(
              builder: (context, state) {
                if (state is CatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CatLoaded) {
                  final cats = state.cats;

                  if (cats.isEmpty) {
                    return const Center(child: Text('No se encontraron razas.'));
                  }

                  return ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      final cat = cats[index];
                      final breed = cat.breeds?.isNotEmpty == true ? cat.breeds![0] : null;

                      return Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /// Fila superior: Nombre y botón "Más..."
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(breed?.name ?? 'Sin nombre', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => CatDetailPage(cat: cat)));
                                    },
                                    child: const Text('Más...', style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              /// Imagen
                              cat.url != null
                                  ? Center(child: Image.network(cat.url!, fit: BoxFit.contain))
                                  : const SizedBox(height: 150, child: Center(child: Text('Sin imagen'))),
                              const SizedBox(height: 8),

                              /// Fila inferior: País de origen e inteligencia
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'País de origen: ${breed?.origin ?? 'Desconocido'}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Inteligencia: ${breed?.intelligence?.toString() ?? 'N/A'}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CatError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
