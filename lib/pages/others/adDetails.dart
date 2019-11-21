import 'package:flutter/material.dart';
import 'package:health/languages/all_translations.dart';

class AdDetailsScreen extends StatefulWidget {
  String imgLInk;
  String text;
  AdDetailsScreen(String link, String text) {
    this.imgLInk = link;
    this.text = text;
  }
  @override
  _AdDetailsScreenState createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allTranslations.text("ad")),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage('http://api.sukar.co/${widget.imgLInk}'),
                    fit: BoxFit.cover),
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.6,
          ),
          SizedBox(
            height: 15,
          ),
                Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child:Text(widget.text,style: TextStyle(fontSize: 20),))
        ],
      ),
    );
  }
}
