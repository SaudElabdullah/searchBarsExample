import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:search/widgets/search_text_field.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({Key? key}) : super(key: key);

  @override
  _BottomSearchState createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  double dy = 0;
  late double top;

  Widget searchBar = Container(
    color: Colors.transparent,
    height: 10,
    width: 10,
  );

  void _start(DragDownDetails details) {
    setState(() {
      dy = details.globalPosition.dy.floorToDouble();
    });
  }

  void _onVerticalDragStartHandler(DragUpdateDetails details) {
    setState(() {
      if (dy - details.globalPosition.dy.floorToDouble() > 0) {
        searchBar = SearchTextField(
          textEditingController: TextEditingController(),
          onTap: (){
            changePosition();
          },
        );
      } else if (dy - details.globalPosition.dy.floorToDouble() < 0) {
        searchBar = Container(
          color: Colors.transparent,
          height: 10,
          width: 10,
        );
      }
    });
  }

  Widget _animation() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        ),
        child: searchBar,
      );

  void changePosition(){
    setState(() {
      top = 30;
    });
  }

  void returnPosition(){
    setState(() {
      top = 650;
    });
  }

  @override
  void initState() {
    super.initState();
    top = 650;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          dragStartBehavior: DragStartBehavior.start,
          onVerticalDragUpdate: _onVerticalDragStartHandler,
          onVerticalDragDown: _start,
          onTap: (){
            returnPosition();
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                color: Colors.red,
                height: 700,
                width: 400,
              ),
              AnimatedPositioned(
                top: top,
                duration: const Duration(milliseconds: 100),
                child: GestureDetector(
                  onTap: (){
                    changePosition();
                  },
                  child: _animation(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
