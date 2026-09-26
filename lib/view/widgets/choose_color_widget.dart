import 'package:flutter/material.dart';
class ChooseColorWidget extends StatefulWidget {
  const ChooseColorWidget({super.key, required this.onColorSelected});
 final void Function(int) onColorSelected;

  @override
  State<ChooseColorWidget> createState() => _ChooseColorWidgetState();
}

class _ChooseColorWidgetState extends State<ChooseColorWidget> {
  @override
  int selectedColor = 0xffFF0000;
  List<int> colorHex = [
    0xffFF0000, //red
    0xff00FF00, //green
    0xff0000FF, //blue
    0xffFFFF00, //yellow
    0xffFF00FF, //purple
    0xff00FFFF, //cyan
    //orange
    0xffFF7F00,
    
  ];
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: colorHex
          .map((color) => colorContainer(color, selectedColor == color))
          .toList(),
    );
  }

  InkWell colorContainer(int colorHex, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onColorSelected(colorHex);
          selectedColor = colorHex;
        });
      },
      child: Container(
        height: 40,
        width: 40,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(colorHex),
          border: isSelected
              ? Border.all(color: Colors.black, width: 3)
              : Border.all(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
