import 'package:flutter/material.dart';
import 'package:the_salon/core/extensions/buildcontext.dart';

class OptionsList extends StatefulWidget {
  final List<String> options;
  final void Function(String selected)? onTap;
  const OptionsList({super.key, required this.options, this.onTap});

  @override
  State<OptionsList> createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.onTap?.call(widget.options[index]);
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              constraints: BoxConstraints(minWidth: 80),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                    selectedIndex == index
                        ? context.colorScheme.secondary
                        : context.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  widget.options[index],
                  style: TextStyle(
                    color:
                        selectedIndex == index
                            ? context.colorScheme.onSecondary
                            : context.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: widget.options.length,
      ),
    );
  }
}
