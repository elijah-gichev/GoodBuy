import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../funcs/firebase_helper/realtime_database.dart';
import '../models/full_product_info.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Добавление отзыва",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error occrurs");
            return Text("Error");
          } else if (snapshot.hasData) {
            return AddReviewForm();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class AddReviewForm extends StatefulWidget {
  final String qr = "1234567890";
  @override
  _AddReviewForm createState() => _AddReviewForm();
}

class _AddReviewForm extends State<AddReviewForm> {
  //final InputDecoration _fieldDecoration = _fieldDecoration();
  final _formKey = GlobalKey<FormState>();
  double _sliderValue = 0;

  final TextEditingController authorController = TextEditingController();
  final TextEditingController textPlusController = TextEditingController();
  final TextEditingController textMinusController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(padding: EdgeInsets.only(top: 10), children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Оценка: $_sliderValue',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorColor: Theme.of(context).accentColor,
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 5,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    activeColor: Colors.green,
                    divisions: 5,
                  ),
                ),
                CustomFormField(
                    'Имя автора', Icon(Icons.face), authorController),
                CustomFormField(
                    'Достоинства',
                    Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    textPlusController),
                CustomFormField(
                    'Недостатки',
                    Icon(
                      Icons.remove_circle_sharp,
                      color: Colors.redAccent[200],
                      size: 20,
                    ),
                    textMinusController),
                CustomFormField(
                    'Комментарий',
                    Icon(
                      Icons.info,
                      color: Theme.of(context).accentColor,
                      size: 20,
                    ),
                    textController),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));

                    String author = authorController.text;
                    int rating = _sliderValue.truncate();

                    DateTime now = new DateTime.now();
                    String date = "${now.year}-${now.month}-${now.day}";

                    String textPlus = textPlusController.text;
                    String textMinus = textMinusController.text;
                    String text = textController.text;
                    String title =
                        text.length > 30 ? text.substring(0, 30) + ".." : text;

                    Review review = Review(
                      author: author,
                      rating: rating,
                      date: date,
                      title: title,
                      textPlus: textPlus,
                      textMinus: textMinus,
                      text: text,
                    );

                    addReview(widget.qr, review); //добавляем в fb

                    // print("rating: $rating");
                    // print("author: $author");
                    // print("plus: $textPlus");
                    // print("minus: $textMinus");
                    // print("text: $text");

                  }
                },
                label: Text(
                  'Создать отзыв',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                icon: Icon(
                  Icons.save,
                  color: Colors.green,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    authorController.dispose();
    textPlusController.dispose();
    textMinusController.dispose();
    textController.dispose();
    super.dispose();
  }
}

class CustomFormField extends StatefulWidget {
  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;

  const CustomFormField(this.labelText, this.prefixIcon, this.controller);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  InputDecoration _fieldDecoration(String labelText, Icon prefixIcon) {
    return InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gapPadding: 10),
        // suffixIcon: Icon(
        //   Icons.error,
        // ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        prefixIcon: prefixIcon);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: widget.controller,
          maxLines: 5,
          minLines: 1,
          //nitialValue: 'Input text',
          decoration: _fieldDecoration(widget.labelText, widget.prefixIcon),
          cursorColor: Colors.green,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}
