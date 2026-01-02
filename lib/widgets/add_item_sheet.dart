import 'package:dolaptakip/models/food_item.dart';
import 'package:dolaptakip/providers/fridge_provider.dart';
import 'package:dolaptakip/data/food_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dolaptakip/l10n/app_localizations.dart';

// AddItemSheet: Ürün eklemek için alttan açılan panel (Bottom Sheet).
class AddItemSheet extends StatefulWidget {
  const AddItemSheet({super.key});

  @override
  State<AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<AddItemSheet> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _selectedDate;
  bool _isOpened = false;
  FoodInfo? _selectedFoodInfo;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      locale: Localizations.localeOf(context), // Use context locale
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  DateTime _calculateEstimatedDate() {
    if (_selectedFoodInfo == null) {
      return DateTime.now().add(const Duration(days: 7));
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

    Color bgColor = Colors.grey.shade800;
    IconData iconData = Icons.fastfood;
    Color iconColor = Colors.white70;

    switch (option.category) {
      case 'Legumes & Grains': // Bakliyat
        bgColor = const Color(0xFF8D6E63);
        iconData = Icons.grain;
        break;
      case 'Snacks': // Atıştırmalık
        bgColor = const Color(0xFFBA68C8);
        iconData = Icons.cookie;
        break;
      case 'Beverages': // İçecek
        bgColor = const Color(0xFF4FC3F7);
        iconData = Icons.local_drink;
        break;
      case 'Fruit & Vegetable': // Meyve & Sebze
        bgColor = const Color(0xFF81C784);
        iconData = Icons.eco;
        break;
      case 'Dairy & Breakfast': // Süt & Kahvaltılık
        bgColor = const Color(0xFFFFF176);
        iconColor = Colors.black45;
        iconData = Icons.egg;
        break;
      case 'Meat & Chicken': // Et & Tavuk
        bgColor = const Color(0xFFE57373);
        iconData = Icons.dinner_dining;
        break;
      case 'Bakery': // Unlu Mamüller
        bgColor = Colors.orangeAccent;
        iconData = Icons.breakfast_dining;
        break;
      case 'Delicatessen': // Şarküteri
        bgColor = Colors.redAccent;
        iconData = Icons.lunch_dining;
        break;
      case 'Sauce & Canned': // Sos & Konserve
        bgColor = Colors.deepOrange;
        iconData = Icons.soup_kitchen;
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
    final l10n = AppLocalizations.of(context)!;
    final effectiveDate = _selectedDate ?? _calculateEstimatedDate();
    final theme = Theme.of(context);

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
                l10n.addItemTitle, // Localized
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

          // --- 1. Otomatik Tamamlamalı Arama Kutusu (Autocomplete) ---
          Autocomplete<FoodInfo>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              final isTr = Localizations.localeOf(context).languageCode == 'tr';
              if (textEditingValue.text == '') {
                final all = List<FoodInfo>.from(FoodData.allItems);
                all.sort(
                  (a, b) => (isTr ? a.nameTr : a.name).compareTo(
                    isTr ? b.nameTr : b.name,
                  ),
                );
                return all;
              }
              return FoodData.allItems.where((FoodInfo option) {
                final optionName = isTr ? option.nameTr : option.name;
                return optionName.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
              });
            },
            displayStringForOption: (FoodInfo option) {
              final isTr = Localizations.localeOf(context).languageCode == 'tr';
              return isTr ? option.nameTr : option.name;
            },
            optionsViewBuilder: (context, onSelected, options) {
              final isTr = Localizations.localeOf(context).languageCode == 'tr';
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: containerColor,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 32,
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      color: containerColor,
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
                            isTr ? option.nameTr : option.name,
                            style: TextStyle(color: textColor),
                          ),
                          subtitle: Text(
                            isTr ? option.categoryTr : option.category,
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
              final isTr = Localizations.localeOf(context).languageCode == 'tr';
              _searchController.text = isTr ? selection.nameTr : selection.name;
              setState(() {
                _selectedFoodInfo = selection;
                _selectedDate = null;
              });
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
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
                    decoration: InputDecoration(
                      labelText: l10n.addItemSearchLabel, // Localized
                      hintText: l10n.addItemSearchHint, // Localized
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: containerColor,
                    ),
                  );
                },
          ),

          if (_selectedFoodInfo != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                // Localized with params
                '${l10n.addItemCategory(Localizations.localeOf(context).languageCode == 'tr' ? _selectedFoodInfo!.categoryTr : _selectedFoodInfo!.category)} • ${l10n.addItemLocation(_selectedFoodInfo!.storageLocation)}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

          const SizedBox(height: 16),

          // --- 2. Paket Durumu Anahtarı (Switch) ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: containerColor,
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
                      l10n.isPackageOpen, // Localized
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _isOpened
                          ? l10n
                                .packageOpenHint // Localized
                          : l10n.packageClosedHint, // Localized
                      style: TextStyle(color: hintColor, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                Switch(
                  value: _isOpened,
                  activeTrackColor: Colors.orange.withAlpha(150),
                  activeThumbColor: Colors.orange,
                  onChanged: (val) {
                    setState(() {
                      _isOpened = val;
                      _selectedDate = null;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- 3. Tarih Seçimi Kartı ---
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor.withAlpha(50)),
                borderRadius: BorderRadius.circular(12),
                color: containerColor,
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
                            ? l10n
                                  .dateAuto // Localized
                            : l10n.dateManual, // Localized
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
                      tooltip: l10n.dateAutomaticTooltip, // Localized
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        l10n.dateEstimated, // Localized
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- Ekleme Butonu ---
          ElevatedButton.icon(
            onPressed: () {
              if (_searchController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.addErrorEmpty)), // Localized
                );
                return;
              }

              final newItem = FoodItem(
                id: DateTime.now().toString(),
                name: _searchController.text,
                expirationDate: effectiveDate,
                addedDate: DateTime.now(),
                category: (_selectedFoodInfo != null)
                    ? (Localizations.localeOf(context).languageCode == 'tr'
                          ? _selectedFoodInfo!.categoryTr
                          : _selectedFoodInfo!.category)
                    : 'Genel',
                imageUrl: _selectedFoodInfo?.imagePath,
              );

              Provider.of<FridgeProvider>(
                context,
                listen: false,
              ).addItem(newItem);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.addSuccess(newItem.name),
                  ), // Localized with param
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text(l10n.addButton), // Localized
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
