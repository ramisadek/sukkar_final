
import 'package:flutter/material.dart';
import 'package:health/MainCircle/CirclurProgressBa.dart';

class ChartWidget extends StatefulWidget {
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
  ChartWidget(
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
  ChartWidgetState createState() {
    return new ChartWidgetState();
  }
}

class ChartWidgetState extends State<ChartWidget> with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    _animation=Tween(begin: 0,end: widget.percent*100).animate(_animationController);
    _animationController.addListener((){
      setState(() {

      });
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
                  SizedBox(width: widget.radius/2,height: widget.radius/2,
                    child: CustomPaint(
                      foregroundPainter: new MyPainter(
                          completeColor: Color.fromRGBO(12, 156, 205, 1),
                          completePercent: _animation.value*1.0,
                          width: 3.0),
                      child: CircleAvatar(
                        radius: (widget.radius - 6) / 2,
                        backgroundColor: widget.color,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                             Image.asset(
                                "assets/icons/${widget.image}.png",width: widget.radius/7,height:widget.radius/7 ,fit: BoxFit.fill,
                              ),
                            
                            Flexible(
                              child: FittedBox(
                                child: Text(widget.title==null?"--": (int.parse(widget.title)*_animationController.value).toInt().toString() ,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,fontSize:widget.radius/12<10?10: widget.radius/12)),
                              ),
                            ),
                            widget.status == null
                                ? Wrap()
                                : FittedBox(
                              child: Text(
                                "${widget.status ?? ''}",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                            widget.time != "" && 100 < widget.radius
                                ?  Text(
                              widget.time,
                              style: TextStyle(
                                  color: Colors.grey,fontSize: 12
                              ),
                            )
                                : SizedBox(
                              width: 0,
                              height: 0,
                            )
                          ],
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