import 'package:flutter/material.dart';

class DragScrollSheetWithFab extends StatefulWidget {
  const DragScrollSheetWithFab(
      {required this.googleMap,
      required this.floatingActionButton,
      required this.builder,
      this.initialSheetChildSize = 0.5});
  final Widget googleMap;
  final FloatingActionButton floatingActionButton;
  final ScrollableWidgetBuilder builder;
  final double initialSheetChildSize;
  @override
  _DragScrollSheetWithFabState createState() => _DragScrollSheetWithFabState();
}

class _DragScrollSheetWithFabState extends State<DragScrollSheetWithFab> {
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  final double _fabPositionPadding = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        // render the floating button on widget
        _fabPosition = widget.initialSheetChildSize * context.size!.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.googleMap,
        Positioned(
          bottom: _fabPosition + _fabPositionPadding,
          right:
              _fabPositionPadding, // Padding to create some space on the right
          child: widget.floatingActionButton,
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            setState(() {
              _widgetHeight = context.size!.height;
              _dragScrollSheetExtent = notification.extent;

              // Calculate FAB position based on parent widget height and DraggableScrollable position
              _fabPosition = _dragScrollSheetExtent * _widgetHeight;
            });
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: widget.initialSheetChildSize,
            maxChildSize: 0.5,
            minChildSize: 0.1,
            builder: widget.builder,
          ),
        ),
      ],
    );
  }
}
