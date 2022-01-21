import 'package:flutter/material.dart';
import 'package:search/utils/size_config.dart';
import 'package:search/widgets/search_text_field.dart';

class SearchBarWithAnimation extends StatefulWidget {
  const SearchBarWithAnimation({Key? key}) : super(key: key);

  @override
  _SearchBarWithAnimationState createState() => _SearchBarWithAnimationState();
}

class _SearchBarWithAnimationState extends State<SearchBarWithAnimation> {
  late TextEditingController textEditingController;
  late List<Widget> changingWidgets;
  late Widget actionWidget;
  late Widget search;
  bool isPressed = false;

  Widget actionButton() {
    setState(() {
      isPressed = !isPressed;
      if (isPressed) {
        actionWidget = changingWidgets[3];
        search = changingWidgets[1];
      } else {
        actionWidget = changingWidgets[2];
        search = changingWidgets[0];
      }
    });
    return actionWidget;
  }

  Widget _animation() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.2, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        ),
        child: search,
      );

  List<Widget> _actions() => ([actionWidget]);

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    changingWidgets = [
      Text(
        'Search bar with animation',
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.textMultiplier! * 2,
        ),
      ),
      SearchTextField(
        textEditingController: textEditingController,
      ),
      IconButton(
        onPressed: () {
          actionButton();
        },
        iconSize: SizeConfig.imageSizeMultiplier! * 10,
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      GestureDetector(
        onTap: () {
          actionButton();
          textEditingController.clear();
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: SizeConfig.widthMultiplier! * 3,
          ),
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.textMultiplier! * 2,
            ),
          ),
        ),
      )
    ];
    search = changingWidgets[0];
    actionWidget = changingWidgets[2];
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.tag_faces,
          color: Colors.white,
          size: SizeConfig.imageSizeMultiplier! * 10,
        ),
        title: _animation(),
        actions: _actions(),
      ),
    );
  }
}
