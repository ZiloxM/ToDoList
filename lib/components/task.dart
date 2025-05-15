import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String title;
  final String time;
  final String date;
  final void Function(DismissDirection)? onDismissed;

  const Task({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    this.onDismissed,
  });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      /// Outer container handles border and radius ..................................................
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Dismissible(
            key: Key(widget.title + widget.time),
            direction: DismissDirection.horizontal,

            /// Archive swipe background ..................................................
            background: Container(
              color: Colors.grey,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Row(
                children: [
                  Icon(Icons.archive, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Archive", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            /// Delete swipe background ..................................................
            secondaryBackground: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Delete", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),

            onDismissed: (direction) {
              if (widget.onDismissed != null) {
                widget.onDismissed!(direction);
              }
            },

            /// Task card content ..................................................
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: const Color(0xfffbb448),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: isChecked ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.orange),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
