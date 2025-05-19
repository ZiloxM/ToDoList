import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategorySheet extends StatefulWidget {
  const CategorySheet({super.key});

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  int selectedIndex = 0;

  String? selectedCategory;
  List<Map<String, dynamic>> categories = [
    {"title": "Work", "color": Colors.blue},
    {"title": "Personal", "color": Colors.green},
    {"title": "Shopping", "color": Colors.orange},
    {"title": "Study", "color": Colors.purple},
  ];

  void _showAddCategoryDialog() {
    String newTitle = '';
    Color newColor = Colors.teal;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Add Category'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration:
                        const InputDecoration(labelText: 'Category title'),
                    onChanged: (value) => newTitle = value,
                  ),
                  const SizedBox(height: 10),
                  BlockPicker(
                    pickerColor: newColor,
                    onColorChanged: (color) {
                      setStateDialog(() {
                        newColor = color;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (newTitle.trim().isNotEmpty) {
                      setState(() {
                        categories.add({
                          'title': newTitle,
                          'color': newColor,
                        });
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Category",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            /// Wrap categories
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...categories.map(
                  (category) {
                    final isSelected = selectedCategory == category['title'];
                    return ChoiceChip(
                      label: Text(category['title']),
                      selected: isSelected,
                      backgroundColor: Colors.grey[200],
                      selectedColor: category['color'].withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? category['color'] : Colors.black,
                      ),
                      avatar: CircleAvatar(
                        backgroundColor: category['color'],
                        radius: 8,
                      ),
                      onSelected: (_) {
                        setState(
                          () {
                            selectedCategory = category['title'];
                          },
                        );
                      },
                    );
                  },
                ).toList(),
                GestureDetector(
                  onTap: _showAddCategoryDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.deepOrange, size: 20),
                        SizedBox(width: 6),
                        Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedCategory);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff7892b),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
