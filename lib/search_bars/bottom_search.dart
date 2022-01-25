import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:search/utils/size_config.dart';
import 'package:search/widgets/search_text_field.dart';

///This search bar works as follow => when scrolling down it hides, and when scrolling top is shows.
///Finally, When pressing, it moves to top.
class BottomSearch extends StatefulWidget {
  const BottomSearch({Key? key}) : super(key: key);

  @override
  _BottomSearchState createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  late double dy;
  late double searchPosition;

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
          passedFunction: (){
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
      searchPosition = SizeConfig.heightMultiplier! * 1;
    });
  }

  void returnPosition(){
    setState(() {
      searchPosition = SizeConfig.heightMultiplier! * 80;
    });
  }

  @override
  void initState() {
    super.initState();
    searchPosition = SizeConfig.heightMultiplier! * 80;
    dy = 0;
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
                color: Colors.transparent,
                height: SizeConfig.heightMultiplier! * 100,
                width: SizeConfig.widthMultiplier! * 100,
              ),
              AnimatedPositioned(
                top: searchPosition,
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
