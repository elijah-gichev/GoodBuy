import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String _formatBarcodeText(String barcode) {
    int maxLength = 30;
    String res = barcode;
    if (barcode == null) {
      res = 'null';
    }

    if (barcode.length > maxLength) {
      res = barcode.substring(0, maxLength) + '...';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ScanFAB(),
      bottomNavigationBar: CustomBottomAppBar(
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
        selectedIndex: 2,
      ),
      body: ListView(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  title: Text('Сыр Российский'),
                  subtitle: Text(
                    'Средняя оценка: 3.5',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  trailing: Text('2 отзыва'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                //пока непонятно, что делать с картинкой, пока их будет 2 в строке
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/product_img_1.png',
                      fit: BoxFit.scaleDown,
                    ),
                    Image.asset(
                      'assets/product_img_2.png',
                      fit: BoxFit.scaleDown,
                    ),
                    // Image.network(
                    //     "https://i.otzovik.com/objects/b/870000/867684.png",)//нужен лоадер
                  ],
                ),
              ],
            ),
          ),
          //теперь будут идти карточки с отзывами
          ReviewCard(
            rate: 3.1,
            title: args,
          ),
          ReviewCard(
            rate: 2,
            title: args,
          ),
          ReviewCard(
            rate: 2.5,
            title: args,
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final double rate;
  final String title;
  final String date = '06.01.2019';
  final String description =
      'Прогуливаясь в магазине Лента увидела в подарочном наборе сыр Камамбер. За два вида цена была 219 рублей. Второй сыр шел в подарок. Редко ем сыры в последнее время, в наших совсем разочаровалась. Но рискнула и...';

  ReviewCard({
    @required this.rate,
    @required this.title,
    //@required this.date,
    //@required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(title ?? "null"),
            subtitle: Text(
              date,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Text(
              '$rate/5',
              style: TextStyle(color: rate <= 3 ? Colors.red : Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 30,
            ),
            title: Text('Цена и качество, да и вообще норм'),
            subtitle: Text(
              'Достоинства',
              style: TextStyle(color: Colors.green.withOpacity(0.6)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30,
            ),
            title: Text('Существование этого производителя и его продукции'),
            subtitle: Text(
              'Недостатки',
              style: TextStyle(color: Colors.red.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
