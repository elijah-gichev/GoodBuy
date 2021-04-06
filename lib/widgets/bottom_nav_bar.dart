import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

//функционал для создания кастомных bottomBar
class CustomAppBarItem {
  IconData icon;
  bool hasNotification;

  CustomAppBarItem({@required this.icon, this.hasNotification});
}

class CustomBottomAppBar extends StatefulWidget {
  //final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;
  int selectedIndex;

  CustomBottomAppBar({@required this.items, @required this.selectedIndex});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  void _selectedTab(int index) {
    //_selectedIndex = index;
    if (index == 0) {
      Navigator.pushNamed(context, '/history');
      QrMobileVision.stop();
    } else if (index == 1) {
      Navigator.pushNamed(context, '/favourite');
      QrMobileVision.stop();
    }
  }

  void _updateIndex(int index) {
    //widget.onTabSelected(index);
    _selectedTab(index);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  Widget _buildTabIcon(
      {int index, CustomAppBarItem item, ValueChanged<int> onPressed}) {
    return Container(
      child: SizedBox(
        height: 60,
        width: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Icon(
              item.icon,
              color: widget.selectedIndex == index ? Colors.green : Colors.grey,
              size: 24,
            ),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      widget.items.length,
      (int index) {
        return _buildTabIcon(
          index: index,
          item: widget.items[index],
          onPressed: _updateIndex,
        );
      },
    );

    return BottomAppBar(
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: items,
        ),
      ),
      shape: CircularNotchedRectangle(),
      color: Colors.white,
    );
  }
}
