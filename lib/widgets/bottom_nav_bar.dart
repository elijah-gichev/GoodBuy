import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

enum Tabs { history, favourite, nothing }

class CustomAppBarItem {
  IconData icon;
  CustomAppBarItem({@required this.icon});
}

class CustomBottomAppBar extends StatefulWidget {
  final List<CustomAppBarItem> items = [
    CustomAppBarItem(icon: Icons.history),
    CustomAppBarItem(icon: Icons.favorite),
  ];
  final Tabs selectedTab;

  CustomBottomAppBar({@required this.selectedTab});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  void _selectedTab(Tabs activeTab) {
    switch (activeTab) {
      case Tabs.history:
        Navigator.pushNamed(context, '/history');
        QrMobileVision.stop();
        break;
      case Tabs.favourite:
        Navigator.pushNamed(context, '/favourite');
        QrMobileVision.stop();
        break;
      case Tabs.nothing:
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildTabIcon(
      {Tabs tab, CustomAppBarItem item, ValueChanged<Tabs> onPressed}) {
    return Container(
      child: SizedBox(
        height: 60,
        width: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(tab),
            child: Icon(
              item.icon,
              color: widget.selectedTab == tab ? Colors.green : Colors.grey,
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
          tab: Tabs.values[index],
          item: widget.items[index],
          onPressed: _selectedTab,
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
