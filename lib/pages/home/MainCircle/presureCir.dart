import 'package:flutter/material.dart';
import '../MainCircle/CirclurProgressBa.dart';

class PressureChartWidget extends StatefulWidget {
  final String title;
  final String image;
  final Widget footer;
  final Color color;
  final double percent;
  final double radius;
  final String status;
  final Function onTap;
  final bool isOnSide;
  final bool isUpper;
  final String time;

  final MainAxisAlignment mainAxisAlignment;
  PressureChartWidget(
      {Key key,
      this.isUpper,
      this.onTap,
      this.isOnSide,
      this.status,
      this.title,
      this.radius,
      this.image,
      this.time,
      this.footer,
      this.color,
      this.percent,
      this.mainAxisAlignment})
      : super(key: key);

  @override
  PressureChartWidgetState createState() {
    return new PressureChartWidgetState();
  }
}

class PressureChartWidgetState extends State<PressureChartWidget>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0, end: widget.percent * 100)
        .animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {
              widget.onTap();
            },
            child: Column(
                mainAxisAlignment: (!widget.isOnSide && !widget.isUpper) ||
                        widget.isOnSide && widget.isUpper
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.radius / 2.2,
                    height: widget.radius / 2.2,
                    child: CustomPaint(
                      foregroundPainter: new MyPainter(
                          completeColor: Color.fromRGBO(12, 156, 205, 19),
                          completePercent: _animation.value * 0.7,
                          width: 3.0),
                      child: CircleAvatar(
                        radius: (widget.radius - 6) / 2,
                        backgroundColor: widget.color,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              widget.status == null
                                  ? Wrap()
                                  : Padding(padding: EdgeInsets.only(top: 20)),
                              Image.asset(
                                "assets/icons/${widget.image}.png",
                                fit: BoxFit.scaleDown,
                                scale: widget.status == null ? 4 : 4.5,
                              ),
                              widget.status == null
                                  ? Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            widget.title == null
                                                ? "--"
                                                : widget.title,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    widget.radius / 12 < 10
                                                        ? 10
                                                        : widget.radius / 12)),
                                      ),
                                    )
                                  : Flexible(
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                  widget.title == null
                                                      ? "--"
                                                      : widget.title,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize:
                                                          widget.radius / 12 <
                                                                  10
                                                              ? 10
                                                              : widget.radius /
                                                                  12)),
                                              Text(
                                                "mg/dl",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )),
                                    ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              widget.status == null
                                  ? Wrap()
                                  : FittedBox(
                                      child: Text(
                                        widget.status,
                                        style: TextStyle(
                                            color: Colors.redAccent, height: 1),
                                      ),
                                    ),
                              widget.status == null
                                  ? Wrap()
                                  : FittedBox(
                                      child: Text(
                                        widget.time,
                                        style: TextStyle(
                                            color: Colors.grey, height: 1),
                                      ),
                                    ),
                              widget.status == null
                                  ? Wrap()
                                  : FittedBox(
                                      // child: Text(

                                      //
                                      //   ///this commeted until we work on the back end
                                      //   //"${widget.status ?? ''}"
                                      //   "",
                                      //   style: TextStyle(color: Colors.grey,height: 1),
                                      // ),
                                      ),
                              widget.status == null
                                  ? Wrap()
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          widget.footer,
        ],
      ),
    );
  }
}
