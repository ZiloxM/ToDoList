import 'package:flutter/material.dart';

class MyCustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final String inactiveText;
  final String activeText;

  const MyCustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    this.activeText = 'ON',
    this.inactiveText = 'OFF',
  });

  @override
  State<MyCustomSwitch> createState() => _MyCustomSwitchState();
}

class _MyCustomSwitchState extends State<MyCustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _setAnimation();
    if (widget.value) _animationController.forward();
  }

  void _setAnimation() {
    _circleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MyCustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value
          ? _animationController.forward()
          : _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: 50,
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:
                  widget.value ? widget.activeColor : const Color(0xfff5f5f5),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!widget.value)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text(
                        widget.inactiveText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (widget.value)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 36),
                      child: Text(
                        widget.activeText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                /// Toggle
                Align(
                  alignment: _circleAnimation.value,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          widget.value ? Colors.white : const Color(0xfff7892b),
                    ),
                    child: Icon(
                      widget.value
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      size: 16,
                      color:
                          widget.value ? const Color(0xfff7892b) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
