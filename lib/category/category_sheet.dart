import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategorySheet extends StatefulWidget {
  const CategorySheet({super.key});

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  int selectedIndex = 0;

  String? hoveredCategory;
  String? selectedCategory;
  List<Map<String, dynamic>> categories = [
    {"title": "Work", "color": Colors.blue},
    {"title": "Personal", "color": Colors.green},
    {"title": "Meeting", "color": Colors.orange},
    {"title": "Study", "color": Colors.purple},
  ];

  void _showAddCategoryDialog() {
    String newTitle = '';
    Color newColor = Colors.red;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Add Category',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333),
                  fontSize: 22,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Category title',
                      labelStyle: const TextStyle(
                        color: Color(0xff333333),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff333333),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff333333),
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: (value) => newTitle = value,
                  ),
                  const SizedBox(height: 15),
                  BlockPicker(
                    pickerColor: newColor,
                    onColorChanged: (color) {
                      setStateDialog(
                        () {
                          newColor = color;
                        },
                      );
                    },
                  ),
                ],
              ),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepOrange.shade400,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff7892b),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (newTitle.trim().isNotEmpty) {
                      setState(
                        () {
                          categories.add(
                            {
                              'title': newTitle,
                              'color': newColor,
                            },
                          );
                        },
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
      backgroundColor: Colors.white,
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
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              selectedCategory = category['title'];
                            },
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isSelected ? category['color'] : Colors.white,
                              width: 2,
                            ),
                            color: isSelected
                                ? category['color'].withOpacity(0.15)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: category['color'],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category['title'],
                                style: TextStyle(
                                  color: isSelected
                                      ? category['color'].shade800
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                InkWell(
                  onTap: _showAddCategoryDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
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

            /// Confirm
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
