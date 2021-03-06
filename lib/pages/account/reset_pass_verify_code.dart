import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/pages/account/change_password.dart';
import 'package:health/pages/Settings.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';
import '../../languages/all_translations.dart';

class ResetPassVerifyCode extends StatefulWidget {
  final String phone;
  ResetPassVerifyCode(this.phone);
  _ResetPassVerifyCodeState createState() => _ResetPassVerifyCodeState();
}

class _ResetPassVerifyCodeState extends State<ResetPassVerifyCode> {
  TextEditingController _controller = new TextEditingController();

  Timer timer;
  int hours;
  int minutes;
  int seconds;
  int endDate;
  bool stop = false;

  final FocusNode _focusNode = FocusNode();

  String code;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmit(BuildContext context, MainModel model) {
    if (!_formKey.currentState.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    model.verifyCodeResetPass({
      "code": code,
      "phone": widget.phone,
    }).then((result) {
      if (result == true) {
        setState(() {
          _isLoading = false;
        });
        // go to check code page
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) {
          return ChangePassword(widget.phone);
        }));
      } else {
        setState(() {
          _isLoading = false;
        });
        // show error
        showInSnackBar("ERROR");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

  void _startCountDown() {
    DateTime now = new DateTime.now();
    int endDate = now.add(Duration(minutes: 1)).toUtc().millisecondsSinceEpoch;
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      var now = DateTime.now().toUtc().millisecondsSinceEpoch;
      var distance = endDate - now;
      Duration remaining = Duration(milliseconds: endDate - now);

      setState(() {
        hours = remaining.inHours;
        minutes = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
            .minute;
        seconds = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
            .second;
      });

      if (distance <= 0) {
        timer.cancel();
        stop = true;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Directionality(
        textDirection: allTranslations.currentLanguage == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: GestureDetector(
            onTap: () {
              _focusNode.unfocus();
            },
            child: Scaffold(
              key: _scaffoldKey,
              body: Form(
                key: _formKey,
                child: ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        _focusNode.unfocus();
                                        Navigator.of(context).pop();
                                      },
                                      child:
                                          Icon(Icons.close, color: Colors.grey),
                                    ),
                                    Center(
                                      child: ImageIcon(
                                          AssetImage(
                                              "assets/icons/ic_verify.png"),
                                          size: 70.0,
                                          color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    ListTile(
                                      title: Text(
                                        allTranslations.text("verifyThat"),
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize:
                                                Platform.isIOS ? 40.0 : 25),
                                      ),
                                      subtitle: Text(
                                        allTranslations.text("enterVerifyCode"),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                Platform.isIOS ? 20.0 : 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            widget.phone ?? "",
                                            style: TextStyle(
                                                fontSize:
                                                    Platform.isIOS ? 30.0 : 20,
                                                color: Colors.grey),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "", counterText: ""),
                                      controller: _controller,
                                      focusNode: _focusNode,
                                      maxLength: 4,
                                      validator: (String val) {
                                        if (val.isEmpty) {
                                          return myLocale.languageCode
                                                  .contains("en")
                                              ? "Code is required"
                                              : "الكود مطلوب";
                                        }
                                      },
                                      onSaved: (String val) {
                                        setState(() {
                                          code = val;
                                        });
                                      },
                                      maxLengthEnforced: true,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  stop
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "${minutes ?? 04}:${seconds ?? 00}",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                              !stop
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        model
                                            .resendVerifyCode(widget.phone)
                                            .then((result) {
                                          if (result == true) {
                                            setState(() {
                                              stop = false;
                                            });
                                            _startCountDown();
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          allTranslations.text("retryAgain"),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      )),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: _isLoading
                                ? CupertinoActivityIndicator(
                                    animating: true,
                                    radius: 15,
                                  )
                                : RaisedButton(
                                    elevation: 0.0,
                                    color: Settings.mainColor(),
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      _focusNode.unfocus();
                                      _handleSubmit(context, model);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        child: Text(
                                          allTranslations.text("verify"),
                                          style: TextStyle(fontSize: 18.0),
                                          textAlign: TextAlign.center,
                                        )),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            )));
  }
}
