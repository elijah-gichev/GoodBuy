import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0;
  void _selectedTab(int index) {
    setState() {
      _selectedIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return HistoryCard(
            'https://yandex-images.naydex.net/u9xIy9384/e7eadehr/BMgchN6a_1tykQaF1YKI2rPwXQiImyW0TPgcBxh3I82OFEfDivvM82zOFv_J8sEhhcBQBEi63SEkH0X6PRVtmkS9HJU7u7-upgAD5UBHe2kQZq_LKyz3s876uEJNojYZf9VWhfk_iFceD8F77gYxF8D2MLEd7h3wFy5E3k4Ejs-naKjg3PmfPvNQY8V0oBj4srWvKXp_dZMsOJiivdA1y1oFFFSYSWn2PQxjai7U4GYTtXIS71-9U4YMNK8_x0x-VChK8R-qDZ3gkkDWx-MrCvHXjkro_0YD_ek40z-QFzvZlxZFeDiZVG4Owatv5aIH4aaAYw8v_zJFfbT-rJWsHxZq28K_CP3M4cNTxCcDCjhyBI6YiT9X4uxJORPdcUdYGlfWlhn4CVY9nTNJ_ncydMGGU9M8rT_h1z1mnNynDjxk-HvgTritT-CRUqS2s_ppYWTsmEk_57Ieyorw39PXa6nFV_U6W_lG_r5jya5XAOeQ5-BxT299UeZth48Ntz2M9yhJUp05Pu1SswJ2BKNICdBkzXupLJZjXBnLg03gxijJtRZHOOnI9jzuo0iPxDIl4UQTQb49bHAX7feeDfaNvtQ5qdAteSzdQ0DgJRYS2PrzJE3Z6vyWIM9YiIBNssdIW-RG1ytraPcdziGK3lQQJgN1UMA9L40jJr81zG4HPz9UuYmjXwtvHiMgQzSH4Pu5sdeuyZs_ZoD8ufpQn_HWubo25qcZu3j3PI7D625HERfid-LzTX6ec-cv1X6Ntx-t5knIsw35Pu4C4dKHRyIKa-FE_9prDpdzLglJEi0x92mKBEVGOUq7hV6sMOhd1NBHYGQhAh8t__EFXTbMzWcurrdJ2qD8ex78wUIjFncS2BoBBYxJ2T6mgBzr-YDPAuQYa7VnlHgbCyVejHPoPYWj9-O0o9Gsj3xDpp7X7W8l7Q_Wmhkhr2leTTODIUSEkEuLoSZNmvhO1XF_6LvAjdA04',
            'Грано Подано Пармеджано',
            3.91,
            9,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/scanner_page');
        },
        child: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.green,
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: _selectedTab,
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String _imgurl;
  final String _heading;
  final double _stars;
  final int _countReviews; //TODO extended info

  HistoryCard(this._imgurl, this._heading, this._stars, this._countReviews);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        _imgurl,
        width: 70,
        height: 70,
      ),
      title: Text(_heading),
      subtitle: Text(
        _stars.toString(),
      ),
      trailing: Icon(Icons.more_vert),
      isThreeLine: false,
    );
  }
}
