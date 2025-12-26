import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemSheet extends StatefulWidget {
  const AddItemSheet({super.key});

  @override
  State<AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<AddItemSheet> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _selectedDate;

  // Mock suggestions
  final List<String> _kFoodOptions = [
    'Süt',
    'Yoğurt',
    'Peynir',
    'Yumurta',
    'Tavuk',
    'Kıyma',
    'Elma',
    'Muz',
    'Domates',
    'Salatalık',
    'Marul',
  ];

  // Category estimation map (in days)
  // Simple keyword matching for demo purposes
  final Map<String, int> _categoryExpirationEstimates = {
    'süt': 7,
    'yoğurt': 10,
    'peynir': 30,
    'yumurta': 21,
    'tavuk': 3,
    'kıyma': 2,
    'elma': 14,
    'muz': 5,
    'domates': 7,
    'salatalık': 5,
    'marul': 4,
  };

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  int _estimateDays(String productName) {
    final nameLower = productName.toLowerCase();
    for (final key in _categoryExpirationEstimates.keys) {
      if (nameLower.contains(key)) {
        return _categoryExpirationEstimates[key]!;
      }
    }
    return 7; // Default 1 week if no match
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ürün Ekle',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return _kFoodOptions.where((String option) {
                return option.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
              });
            },
            onSelected: (String selection) {
              _searchController.text = selection;
            },
            fieldViewBuilder:
                (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  // Sync local controller if needed, or just use the one provided
                  // But we need the value for estimation logic, so let's keep _searchController referenced or updated
                  if (textEditingController.text != _searchController.text &&
                      _searchController.text.isNotEmpty) {
                    textEditingController.text = _searchController.text;
                  }
                  // Listen to changes to keep _searchController updated for logic usage
                  textEditingController.addListener(() {
                    _searchController.text = textEditingController.text;
                  });

                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Ekleyeceğiniz ürün',
                      hintText: 'Örn: Süt',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                    ),
                  );
                },
          ),
          const SizedBox(height: 16),
          // Date Picker Section
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade600),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[900],
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text(
                    _selectedDate == null
                        ? 'SKT Seç (Otomatik)'
                        : 'SKT: ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}',
                    style: TextStyle(
                      color: _selectedDate == null ? Colors.grey : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  if (_selectedDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_searchController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lütfen bir ürün adı girin.')),
                );
                return;
              }

              // Logic to determine final date
              DateTime finalDate;
              bool isEstimated = false;

              if (_selectedDate != null) {
                finalDate = _selectedDate!;
              } else {
                final daysToAdd = _estimateDays(_searchController.text);
                finalDate = DateTime.now().add(Duration(days: daysToAdd));
                isEstimated = true;
              }

              // Create Item
              final newItem = FoodItem(
                id: DateTime.now().toString(), // Simple ID generation
                name: _searchController.text,
                expirationDate: finalDate,
                addedDate: DateTime.now(),
                category: 'Genel', // Default category for now
                imageUrl: null, // Will be updated when we have assets
              );

              // Add to Provider
              Provider.of<FridgeProvider>(
                context,
                listen: false,
              ).addItem(newItem);

              Navigator.pop(context);

              // Formatting for display
              final dateStr =
                  '${finalDate.day}.${finalDate.month}.${finalDate.year}';
              final message = isEstimated
                  ? 'Ürün eklendi! Tahmini SKT: $dateStr'
                  : 'Ürün eklendi! SKT: $dateStr';

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            icon: const Icon(Icons.add),
            label: const Text('Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
