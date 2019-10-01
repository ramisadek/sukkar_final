import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/Models/home_model.dart';
import 'package:health/helpers/loading.dart';
import 'package:health/pages/measurement/addsugar.dart';
import 'package:health/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';
import '../../shared-data.dart';
import 'MainCircle/Circles.dart';
import 'package:health/pages/home/articleDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:health/pages/Settings.dart';
import '../../languages/all_translations.dart';
import 'package:health/pages/Settings.dart' as settings;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:screenshot_share_image/screenshot_share_image.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;
  final MainModel model;

  HomePage({@required this.pageController, this.model});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  PageController _bottomChartsPageViewController = PageController();

//width of the screen to init the siwiper postion
  int _stepCountValue;
  StreamSubscription _subscription;
  var dateSplit;
//to know where it's first time or not user to idnitfy swiper postion
  bool _firstPageLoad = true;
//scrollController to init the swiper postion
  ScrollController _scrollController;
  Response response;
//  Map dataHome;
  MeasurementsBean dataHome;
  List<BannersListBean> banners = List<BannersListBean>();
  double dataCharts0 = 0.0;
  double dataCharts1 = 0.0;
  double dataCharts2 = 0.0;
  double dataCharts3 = 0.0;
  double dataCharts4 = 0.0;
  double dataCharts5 = 0.0;
  double dataCharts6 = 0.0;
  bool loading;
  bool loading1;
  bool loading2;
  bool initOpen = true;

  List<dynamic> datesOfMeasures = [" "," "," "," "," "," "," "]; 
  List<dynamic> measuresData  = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
  
  
 
  bool istrue = false;
  List newList = [];
  List<int> _calories = [];
  DateTime selectedDate = DateTime.now();
  var date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  init(BuildContext context) {
    _scrollController = ScrollController(
        initialScrollOffset: MediaQuery.of(context).size.width - 130);
        
  }

  initState() {
    super.initState();
    emptylists();
    getCustomerData();
    getHomeFetch();
    getcal();
    getMeasurements(date);
  }

  int ncal=1;
  void getcal() async {
    print("waaw===========");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("waaw===========");

    ncal = prefs.getInt('calTarget');
    if (ncal == null || ncal == 0) {
      ncal = 1200;
    }
    print('YOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYO');
    print(ncal);
    print('YOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYOYO');
  }

  Dio dio = new Dio();

  final String baseUrl = 'http://104.248.168.117/api';


  Future<Response> getMeasurements(String date1) async {
    Response response;
   
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, dynamic> authUser =
          jsonDecode(sharedPreferences.getString("authUser"));
      var headers = {
        "Authorization": "Bearer ${authUser['authToken']}",
      };

      response = await dio.get("$baseUrl/measurements/sugarReads?date=$date1",
          options: Options(headers: headers));
      print(response.data);    

      List<dynamic> date = new List();
      List<dynamic> suger = new List();
      print(datesOfMeasures);
      print("==================");
      for (int i = 0; i <= 6; i++) {
              print("==================$i");

        date.add(response.data['week'][i]['date']);
        print("==================0000000");
        suger.add(response.data['week'][i]['sugar']);

        print("==================0000000333333");

      }
      datesOfMeasures = date;
      print(datesOfMeasures);
      measuresData = suger;
      print(measuresData);
      setState(() {
        
      });
    } catch (e) {
      print("error =====================");
    }

    print('++++++++++++++++++++++++++++++++++from here we end the GETCAL');
    return response;
  }
  void emptylists(){

    for(var i = 0 ;i<=6;i++){
      datesOfMeasures[i]=" ";
      for(var j=0 ; j<3;j++){
        measuresData[i][j] = 0;

      }
      
    }
  }


  void incrementWeek() {
    istrue = true;
    selectedDate = selectedDate.add(new Duration(days: 7));
     emptylists();
     setState(() {
      
    });
    print(
        "waaaaaaa&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    Future.delayed(Duration(milliseconds: initOpen ? 300 : 300), () {
      initOpen = false;
      istrue = false;
      print(
          "waaaaaaa++++++++++++++++++++++++++___________________________________________________________");

      setState(() {
        
        date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
        print(date);
        getMeasurements(date);
        selectedDate = selectedDate;
      });
    });
  }

  
  void decrementWeek() {
    istrue = true;
    selectedDate = selectedDate.subtract(new Duration(days: 7));
    emptylists();
    setState(() {
      
    });
   print(
        "waaaaaaa&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    Future.delayed(Duration(milliseconds: initOpen ? 100 : 100), () {
      initOpen = false;
      istrue = false;
      print(
          "waaaaaaa++++++++++++++++++++++++++___________________________________________________________");
      setState(() {
        
        date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
        print(date);
        getMeasurements(date);
        selectedDate = selectedDate;
      });
    });
  }

  getHomeFetch() {
    setState(() {
      loading = true;
      loading1 = true;
    });
    widget.model.fetchHome(date).then((result) {
      print('*****************************************************');
      print('HERE is the start of Result');
      print(result == null ? 'fffff' : 'yyyy');
      print('*****************************************************');
      if (result != null) {

        setState(() {
          // Measurements
          dataHome = result.measurements;
          // Sugar Charts
          setState(() {
            // Articles banner
            banners = result.banners;
            loading1 = false;
            loading = false;
          });
        });
      }
    });
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = stepCountValue);
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void _onCancel() => _subscription.cancel();

  //------------------ END STEP COUNTER -------------//

  void _handleSubmitted(
      BuildContext context, MainModel model, var value, String type) {
    model.addMeasurements(type, value).then((result) async {
//      print(result);
    });
  }

  dispose() {
    // _onCancel();
    super.dispose();
  }

  Widget upperCircles(context, _chartRadius, model) {
    return loading == true
        ? Loading()
        : CustomMultiChildLayout(
            delegate: CirclesDelegate(_chartRadius),
            children: <Widget>[
              new LayoutId(
                id: 1,
                child: MainCircles.diabetes(
                  percent: dataHome.sugar == null?0:(dataHome.sugar/600)*0.7,
                  context: context,
//                sugar: dataHome['sugar'].toString(),
                  sugar: dataHome == null
                      ? '0'
                      : dataHome.sugar == null
                          ? '0'
                          : dataHome.sugar.toString(),
                  raduis: _chartRadius,
                  status: dataHome == null
                      ? '0'
                      : dataHome.sugar == null
                          ? '0'
                          : (dataHome.sugar <= 100
                              ? allTranslations.text("good")
                              : dataHome.sugar <= 125
                                  ? allTranslations.text("normal")
                                  : dataHome.sugar > 126
                                      ? allTranslations.text("high")
                                      : ''),
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddSugar(selectedDate)),
                    );
                  },
                  footer: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: _chartRadius / 9,
                        width: _chartRadius / 5,
                      ),
                      Expanded(
                          child: InkWell(
                        child: ImageIcon(
                          AssetImage("assets/icons/ic_camera.png"),
                          color: Colors.grey[300],
                          size: 15,
                        ),
                        onTap: () =>
                            ScreenshotShareImage.takeScreenshotShareImage(),
                      )),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.pageController.animateToPage(3,
                                duration: Duration(
                                  milliseconds: 10,
                                ),
                                curve: Curves.bounceIn);
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundImage:
                                      AssetImage("assets/imgs/profile.jpg"),
                                ),
                              ),
                              Positioned(
                                left: 8.5,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundImage:
                                      AssetImage("assets/imgs/profile.jpg"),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                child: Icon(
                                  Icons.add,
                                  size: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _chartRadius / 5,
                      ),
                    ],
                  ),
                ),
              ),
              new LayoutId(
                  id: 2,
                  child: MainCircles.cal(
                      percent: dataHome == null
                          ? 0
                          : dataHome.calories == null
                              ? 0
                              : ((dataHome.calories / ncal)*0.7),
                      context: context,
//                day_Calories: dataHome['day_Calories'],
                      day_Calories: dataHome == null
                          ? 0
                          : dataHome.calories == null
                              ? 0
                              : dataHome.calories.toString(),
                      ontap: () => null,
                      raduis: _chartRadius,
                      footerText: "Cal " +
                          " ${ncal} :" +
                          allTranslations.text("Goal is"))),
              new LayoutId(
                id: 3,
                child: MainCircles.steps(
                    percent: dataHome == null
                        ? 0
                        : dataHome.steps == null
                            ? 0
                            : (dataHome.steps / (ncal / 0.0912))*0.7,
                    context: context,
//              steps: dataHome['NumberOfSteps'] ?? 0,
                    steps: dataHome == null
                        ? 0
                        : dataHome.steps == null ? 0 : dataHome.steps,
                    raduis: _chartRadius,
                    onTap: () => null,
                    footerText: " Step " +
                        "${(ncal / 0.0912).toInt()} :" +
                        allTranslations.text("Goal is")),
              ),
              new LayoutId(
                id: 4,
                child: MainCircles.distance(
                    percent: dataHome == null
                        ? 0
                        : dataHome.distance == null
                            ? 0
                            : dataHome.distance /
                                (((ncal / 0.0912) * 0.762) ~/ 2)*0.7,
                    context: context,
                    raduis: _chartRadius,
//              distance: dataHome['distance'].toString(),
                    distance: dataHome == null
                        ? '0'
                        : dataHome.distance == null
                            ? '0'
                            : dataHome.distance.toString(),
                    onTap: () => null,
                    footerText: " meter " +
                        "${(((ncal/ 0.0912) * 0.762) / 2).toInt()} :" +
                        allTranslations.text("Goal is")),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    if (_firstPageLoad) {
      init(context);
      _firstPageLoad = false;
    }
    // get free pixels free to render widgets on it
    // 40 appbar heigth
    //56 bottom navigation bar heigth
    //   MediaQuery.of(context).padding.top is the height of status bar
    double _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        40 -
        56;
    //check if the width or height ratio is bigger so no overlaying occur
    double _chartRadius =
        (_screenHeight * 3 / 5 - MediaQuery.of(context).padding.top - 40 - 56 <
                    MediaQuery.of(context).size.width - 30
                ? _screenHeight * 3 / 5
                : MediaQuery.of(context).size.width - 30) /
            2;

    return Scaffold(
        appBar: Settings.appBar(
          context: context,
          title: InkWell(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(DateTime.now().year - 1),
                  maxTime: DateTime(DateTime.now().year + 1), onConfirm: (e) {
                print('confirm $e');
                setState(() {
                  date = '${e.year}-${e.month}-${e.day}';
                  print(date);
                  getHomeFetch();
                  getMeasurements(date);

                  selectedDate = e;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: Row(
              children: <Widget>[
                Text(
                  '$date',
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ImageIcon(
                    AssetImage("assets/icons/ic_calendar.png"),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child:
//                    ListView(
//                      children: <Widget>[
//                        Text('${newList}')
//                      ],
//                    )

                new ListView(
                  children: <Widget>[
                    SizedBox(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.455,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: InkWell(
                                    child: Image.asset(
                                      "assets/icons/ic_arrow_r.png",
                                      matchTextDirection: true,
                                      width: 15,
                                      height: MediaQuery.of(context).size.height * 3 / 5,
                                    ),
                                    onTap: () {
                                      widget.pageController.animateToPage(2,
                                          duration: Duration(milliseconds: 10),
                                          curve: Curves.bounceIn);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: upperCircles(context, _chartRadius, model),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.pageController.animateToPage(0,
                                        curve: Curves.bounceIn,
                                        duration: Duration(milliseconds: 10));
                                  },
                                  child: Image.asset(
                                    "assets/icons/ic_arrow_r.png",
                                    width: 15,
                                    height: MediaQuery.of(context).size.height * 3 / 5,
                                    matchTextDirection: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          new Expanded(
                            flex: 2,
                            child: loading2 == true
                                ? Padding(
                              padding: EdgeInsets.all(20),
                              child: Loading(),
                            )
                                : Column(
                              children: <Widget>[
                                new SizedBox(
                                  height: MediaQuery.of(context).size.height / 10,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: banners.length,
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        return banners[index].type == 'advertise'
                                            ? new Container(
                                          decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'http://104.248.168.117/${banners[index].image}'),
                                                  fit: BoxFit.cover),
                                              color: Colors.grey[200],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width -
                                              100,
                                        )
                                            : new InkWell(
                                          onTap:
//                                    newList[index]['name'] == null
//                                        ? null:
                                              () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetails(
                                                        model,
                                                        banners[index].name,
                                                        banners[index].id),
                                              ),
                                            );
                                          },
                                          child: new Container(
                                            decoration: ShapeDecoration(
                                                color: Colors.grey[200],
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10))),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width -
                                                100,
                                            child:
//                                      newList[index]['name'] == null
//                                          ? Image.network(
//                                              "http://104.248.168.117/${newList[index]['image']}",
//                                              fit: BoxFit.cover,
//                                            )
//                                          :
                                            new Row(
                                              children: <Widget>[
                                                new Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        child: Text(
                                                          banners[index].name,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  41,
                                                                  172,
                                                                  216,
                                                                  1),
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            top: 10),
                                                        child: Text(
                                                          banners[index]
                                                              .created,
                                                          style: TextStyle(
                                                            color:
                                                            Colors.grey,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 130,
                                                  height: 100,
                                                  child: ClipRRect(
                                                    child: Image.network(
                                                      "http://104.248.168.117/${banners[index].image}",
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                //new chart
                                loading1 == true
                                    ? Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Loading(),
                                )
                                    : new Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.24,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: <Widget>[
                                      InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .padding
                                                  .bottom +
                                                  60),
                                          child: Image.asset(
                                            'assets/icons/ic_arrow_small_l.png',
                                            scale: 2,
                                          ),
                                        ),
                                        onTap: () => decrementWeek(),
                                      ),
                                      Container(

                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.9,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.24,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SwipeDetector(
                                              onSwipeRight:(){
                                                incrementWeek();
                                              },
                                              onSwipeLeft: () {
                                                decrementWeek();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: charts(),

                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.9,
                                                height: 1,
                                                color: Colors.grey[500]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("saturday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[0].split("-")[1]}/${datesOfMeasures[0].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("sunday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[1].split("-")[1]}/${datesOfMeasures[1].split("-")[2]}',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                16 /
                                                                720,
                                                            color:
                                                            Colors.grey),
                                                        textScaleFactor: 1.0),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("monday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[2].split("-")[1]}/${datesOfMeasures[2].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("tuesday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[3].split("-")[1]}/${datesOfMeasures[3].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("wednesday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[4].split("-")[1]}/${datesOfMeasures[4].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("thursday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " " ? " ":
                                                    '${datesOfMeasures[5].split("-")[1]}/${datesOfMeasures[5].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      allTranslations
                                                          .text("friday"),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              21 /
                                                              720,
                                                          color: Colors.grey),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                    Text(datesOfMeasures[0][0] == " "? " ":
                                                    '${datesOfMeasures[6].split("-")[1]}/${datesOfMeasures[6].split("-")[2]}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              16 /
                                                              720,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .padding
                                                  .bottom +
                                                  60),
                                          child: Image.asset(
                                            'assets/icons/ic_arrow_small_r.png',
                                            scale: 2,
                                          ),
                                        ),
                                        onTap: () {
                                          if(selectedDate.isAfter(DateTime.now())){
                                          }
                                          else{
                                            incrementWeek();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.height*0.83,
                    )
                  ],
                ),
          );
        }));
  }

//  final Color leftBarColor = Color(0xff53fdd7);
  final Color rightBarColor = Colors.redAccent;
  final double width = 7;
  final Color barBackgroundColor = Colors.grey.shade200;

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 20,
          color: barBackgroundColor,
        ),
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    double width = 4.5;
    double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  List<Widget> charts() {
    List<Widget> list = new List();
    for (int i = 0; i <= 6; i++) {
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: inChart(i),
      ));
      list.add(
        Container(
          width: 1.2,
          height: MediaQuery.of(context).size.height * 0.17,
          color: Colors.grey,
        ),
      );
    }
    return list;
  }

  List<Widget> inChart(int i) {
    List<Widget> list2 = new List();
    for (int j = 0; j < 3; j++) {
       int val=0;
       val = measuresData[i][j];
      
      Color barColor;

      if (val <= 120 && val >= 70) {
        barColor = Colors.green[300];
      } else if (val >= 200||val < 50) {
        barColor = Color(0xFFd17356);
      } else {
        barColor = Colors.yellow[800];
      }

      list2.add(Column(
        children: <Widget>[
          Text(
            val == 0 ? "" : "${val}",
            style: TextStyle(
                color: barColor,
                fontSize: MediaQuery.of(context).size.width * 15 / 720),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: istrue ? 300 : 300),
            height: val <= 0? 0.1 :val.toDouble() > 300 ? 100
                : (val.toDouble() / 600) * 200,
            width: MediaQuery.of(context).size.width * 16 / 720,
            decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
          ),
        ],
      ));
    }
    return list2;
  }

  _showBottomSheet(
      {BuildContext context,
      MainModel model,
      String title,
      String type,
      String subTitle,
      String imageName,
      double min,
      double max}) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return settings.BottomSheet(
              title: title,
              subtitle: subTitle,
              image: imageName,
              min: min,
              max: max,
              addSlider: true,
              onSave: (String value) {
                _handleSubmitted(context, model, value, type);
              });
        });
  }
}

class CirclesDelegate extends MultiChildLayoutDelegate {
  final double raduis;

  CirclesDelegate(this.raduis);

  @override
  void performLayout(Size size) {
    if (hasChild(1)) {
      layoutChild(
          1,
          BoxConstraints(
              maxWidth: size.width / 2, maxHeight: size.width / 2 + 30));
      positionChild(1, Offset(size.width / 4, 0));
    }
    if (hasChild(2)) {
      layoutChild(
          2, BoxConstraints(maxWidth: raduis, maxHeight: (raduis / 2 + 46)));
      positionChild(
          2,
          Offset(size.width - raduis / 2 - 20 / 560 * size.width,
              290 / 500 * size.height - raduis / 8));
    }
    if (hasChild(3)) {
      layoutChild(
          3, BoxConstraints(maxWidth: raduis, maxHeight: (raduis / 2 + 46)));
      positionChild(
          3,
          Offset(size.width / 2 - raduis / 4,
              size.height - (raduis / 2) - 20 - 20));
    }
    if (hasChild(4)) {
      layoutChild(
          4, BoxConstraints(maxWidth: raduis, maxHeight: (raduis / 2 + 46)));
      positionChild(4,
          Offset(20 / 560 * size.width, 290 / 500 * size.height - raduis / 8));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
