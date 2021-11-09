import 'package:flutter/material.dart';

class StationTile extends StatefulWidget {
  const StationTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onChanged})
      : super(key: key);

  final void Function(int?)? onChanged;
  final String subtitle;
  final String title;
  @override
  _StationTileState createState() => _StationTileState();
}

class _StationTileState extends State<StationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: Radio<int>(
        value: 0,
        groupValue: 1,
        onChanged: widget.onChanged,
        activeColor: Colors.green,
      ),
      subtitle: Text(widget.subtitle),
    );
  }
}
