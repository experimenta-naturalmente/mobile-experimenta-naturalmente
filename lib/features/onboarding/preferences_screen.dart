import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final int currentPage;
  final int totalPages;
  final Future<void> Function(List<String> preferences)? onFinish;

  const PreferencesScreen({
    Key? key,
    this.onBack,
    this.currentPage = 2,
    this.totalPages = 3,
    this.onFinish,
  }) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<String> _allPreferences = [
    'Fazendas',
    'Cachoeiras',
    'Hotéis',
    'Restaurantes',
    'Pontos Turísticos',
    'Compras',
  ];

  final List<String> _selectedPreferences = [];

  final Map<String, String> _preferenceImages = {
    'Fazendas': 'assets/images/fazenda.jpg',
    'Cachoeiras': 'assets/images/cachoeira.jpg',
    'Hotéis': 'assets/images/hotel.jpg',
    'Restaurantes': 'assets/images/restaurante.jpg',
    'Pontos Turísticos': 'assets/images/ponto_turistico.jpg',
    'Compras': 'assets/images/compras.jpg',
  };

  void _togglePreference(String pref) {
    setState(() {
      if (_selectedPreferences.contains(pref)) {
        _selectedPreferences.remove(pref);
      } else {
        _selectedPreferences.add(pref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
                const SizedBox(width: 4),
                const Text(
                  'O que você mais gosta/curte/prefere?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: _allPreferences.map((pref) {
                    final selected = _selectedPreferences.contains(pref);
                    return GestureDetector(
                      onTap: () => _togglePreference(pref),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Image.asset(
                                  _preferenceImages[pref]!,
                                  width: 120,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                if (selected)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.check_circle, color: Color(0xFF5B6842)),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            pref,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.totalPages,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == widget.currentPage
                        ? const Color(0xFF5B6842)
                        : const Color(0xFFD9D9D9),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedPreferences.isNotEmpty
                      ? () async {
                          if (widget.onFinish != null) {
                            await widget.onFinish!(_selectedPreferences);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B6842),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
