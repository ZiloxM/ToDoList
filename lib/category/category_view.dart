import 'package:flutter/material.dart';
import 'package:todo_list/category/category.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "All", "color": Colors.red},
    {"title": "Work", "color": Colors.blue},
    {"title": "Personal", "color": Colors.green},
    {"title": "Shopping", "color": Colors.orange},
    {"title": "Study", "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryItem(
              title: category['title'],
              color: category['color'],
              isSelected: selectedIndex == index,
              onTap: () {
                setState(
                  () {
                    selectedIndex = index;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
