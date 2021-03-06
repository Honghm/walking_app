import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/provider/timer_provider.dart';
import 'bottom_curved_Painter.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onIconPresedCallback;
  CustomBottomNavigationBar({Key key, this.onIconPresedCallback}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;
  AnimationController _xController;
  AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    const buttonCount = 3.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(IconData icon, bool isEnable, int index, BuildContext context) {
    final time = Provider.of<TimerProvider>(context);
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        onTap: () {
          _handlePressed(index);
          if(index==1)
            time.startTimeLoading();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
            height: isEnable ? 40 : 25,
            duration: Duration(milliseconds: 300),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isEnable ? Colors.orange : Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: isEnable ? Color(0xfffeece2) : Colors.black54,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(5, 5),
                  ),
                ],
                shape: BoxShape.circle),
            child:Opacity(
              opacity:isEnable ? _yController.value : 1,
              child: Icon(icon,
                color: isEnable
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            )
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    final inCurve = ElasticOutCurve(0.38);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: CustomPaint(
        painter: BackgroundCurvePainter(
            _xController.value * MediaQuery.of(context).size.width,
            Tween<double>(
              begin: Curves.easeInExpo.transform(_yController.value),
              end: inCurve.transform(_yController.value),
            ).transform(_yController.velocity.sign * 0.5 + 0.5),
            Colors.black54),
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 620));
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        _yController.animateTo(1.0, duration: Duration(milliseconds: 1200));
      },
    );
    _yController.animateTo(0.0, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 50.0;
    return Container(
      width: appSize.width,
      height: 50,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 3,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _icon(Icons.description, _selectedIndex == 0, 0, context),
                _icon(Icons.home, _selectedIndex == 1, 1,context),
                _icon(Icons.insert_chart, _selectedIndex == 2, 2,context),
              ],
            ),
          ),
        ],
      ),
    );
}
}
