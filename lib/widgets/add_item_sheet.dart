import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:dolaptakip/data/food_data.dart';
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
  bool _isOpened = false; // New state for package status
  FoodInfo? _selectedFoodInfo; // To store selected item data

  // No longer needed: _kFoodOptions, _categoryExpirationEstimates

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 5),
      ), // Increased range
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  DateTime _calculateEstimatedDate() {
    if (_selectedFoodInfo == null) {
      return DateTime.now().add(const Duration(days: 7)); // Default fallback
    }

    final daysToAdd = _isOpened
        ? _selectedFoodInfo!.openedDurationInDays
        : _selectedFoodInfo!.unopenedDurationInDays;

    return DateTime.now().add(Duration(days: daysToAdd));
  }

  Widget _buildProductImage(FoodInfo option) {
    if (option.imagePath != null) {
      return CircleAvatar(
        backgroundImage: AssetImage(option.imagePath!),
        backgroundColor: const Color(0xFFF5F7FA),
        radius: 20,
      );
    }

    // Styled placeholder based on category
    Color bgColor = Colors.grey.shade800;
    IconData iconData = Icons.fastfood;
    Color iconColor = Colors.white70;

    switch (option.category) {
      case 'Bakliyat':
        bgColor = const Color(0xFF8D6E63); // Brownish
        iconData = Icons.grain;
        break;
      case 'Atıştırmalık':
        bgColor = const Color(0xFFBA68C8); // Purple
        iconData = Icons.cookie;
        break;
      case 'İçecek':
        bgColor = const Color(0xFF4FC3F7); // Light Blue
        iconData = Icons.local_drink;
        break;
      case 'Meyve & Sebze':
        bgColor = const Color(0xFF81C784); // Green
        iconData = Icons.eco;
        break;
      case 'Süt & Kahvaltılık':
        bgColor = const Color(0xFFFFF176); // Yellow
        iconColor = Colors.black45;
        iconData = Icons.egg;
        break;
      case 'Et & Tavuk':
        bgColor = const Color(0xFFE57373); // Red
        iconData = Icons.dinner_dining;
        break;
      default:
        bgColor = Colors.blueGrey;
        iconData = Icons.restaurant;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Current effective date (Manual or Estimated)
    final effectiveDate = _selectedDate ?? _calculateEstimatedDate();
    final theme = Theme.of(context);

    // Colors derived from theme
    final containerColor =
        theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final borderColor = theme.dividerColor;
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final hintColor = theme.hintColor;

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
                style: theme.textTheme.headlineSmall?.copyWith(
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

          // 1. Autocomplete Search
          Autocomplete<FoodInfo>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                final all = List<FoodInfo>.from(FoodData.allItems);
                all.sort((a, b) => a.name.compareTo(b.name));
                return all;
              }
              return FoodData.allItems.where((FoodInfo option) {
                return option.name.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
              });
            },
            displayStringForOption: (FoodInfo option) => option.name,
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: containerColor,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width -
                        32, // Match parent width roughly
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      color: containerColor, // Theme adjusted
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final FoodInfo option = options.elementAt(index);
                        return ListTile(
                          leading: _buildProductImage(option),
                          title: Text(
                            option.name,
                            style: TextStyle(color: textColor),
                          ),
                          subtitle: Text(
                            option.category,
                            style: TextStyle(color: hintColor, fontSize: 12),
                          ),
                          onTap: () => onSelected(option),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (FoodInfo selection) {
              _searchController.text = selection.name;
              setState(() {
                _selectedFoodInfo = selection;
                _selectedDate = null; // Reset manual date to use new estimate
              });
            },
            fieldViewBuilder:
                (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  // Sync logic
                  if (textEditingController.text != _searchController.text &&
                      _searchController.text.isNotEmpty) {
                    textEditingController.text = _searchController.text;
                  }
                  textEditingController.addListener(() {
                    _searchController.text = textEditingController.text;
                  });

                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onTap: () {
                      if (textEditingController.text.isEmpty) {
                        textEditingController.value = TextEditingValue(
                          text: textEditingController.text,
                          selection: textEditingController.selection,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Ekleyeceğiniz ürün',
                      hintText: 'Örn: Süt',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: containerColor, // Theme adjusted
                    ),
                  );
                },
          ),

          // Show category/info if selected
          if (_selectedFoodInfo != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                'Kategori: ${_selectedFoodInfo!.category} • Yeri: ${_selectedFoodInfo!.storageLocation}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

          const SizedBox(height: 16),

          // 2. Package Open Switch
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: containerColor, // Theme adjusted
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  _isOpened
                      ? Icons.lock_open_rounded
                      : Icons.lock_outline_rounded,
                  color: _isOpened
                      ? Colors.orange
                      : theme.colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paketi Açık mı?',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _isOpened
                          ? 'Daha kısa ömürlü olabilir.'
                          : 'Raf ömrü baz alınır.',
                      style: TextStyle(color: hintColor, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                Switch(
                  value: _isOpened,
                  activeColor: Colors.orange,
                  onChanged: (val) {
                    setState(() {
                      _isOpened = val;
                      _selectedDate = null; // Recalculate based on new state
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 3. Date Selection
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor.withAlpha(50)),
                borderRadius: BorderRadius.circular(12),
                color: containerColor, // Theme adjusted
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.grey),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Otomatik Hesaplanan SKT'
                            : 'Seçilen SKT',
                        style: TextStyle(color: hintColor, fontSize: 12),
                      ),
                      Text(
                        '${effectiveDate.day}.${effectiveDate.month}.${effectiveDate.year}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (_selectedDate != null)
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 20),
                      tooltip: 'Otomatiğe Dön',
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Tahmini',
                        style: TextStyle(color: Colors.orange, fontSize: 10),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Action Button
          ElevatedButton.icon(
            onPressed: () {
              if (_searchController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lütfen bir ürün adı girin.')),
                );
                return;
              }

              // Create Item
              final newItem = FoodItem(
                id: DateTime.now().toString(),
                name: _searchController.text,
                expirationDate: effectiveDate,
                addedDate: DateTime.now(),
                // Use selected info category if avaiable, else 'Genel'
                category: _selectedFoodInfo?.category ?? 'Genel',
                imageUrl: _selectedFoodInfo?.imagePath,
              );

              Provider.of<FridgeProvider>(
                context,
                listen: false,
              ).addItem(newItem);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${newItem.name}" dolabına eklendi!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
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
