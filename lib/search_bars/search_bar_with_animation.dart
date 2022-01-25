import 'package:flutter/material.dart';
import 'package:search/utils/size_config.dart';
import 'package:search/widgets/search_text_field.dart';


///This widget is an search bar with title and animation.
///Feel free to run it and see how it works.
class SearchBarWithAnimation extends StatefulWidget {
  const SearchBarWithAnimation({Key? key}) : super(key: key);

  @override
  _SearchBarWithAnimationState createState() => _SearchBarWithAnimationState();
}

class _SearchBarWithAnimationState extends State<SearchBarWithAnimation> {
  late TextEditingController textEditingController;
  late List<Widget> widgetsList;
  late Widget actionWidget;
  late Widget search;
  late bool isPressed;

  Widget actionButton() {
    setState(() {
      isPressed = !isPressed;
      if (isPressed) {
        actionWidget = widgetsList[3];
        search = widgetsList[1];
      } else {
        actionWidget = widgetsList[2];
        search = widgetsList[0];
      }
    });
    return actionWidget;
  }

  Widget _animation() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          ),
      child: search,
    );
  }

  List<Widget> _actions() => ([actionWidget]);

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    widgetsList = [
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
      Center(
        child: Padding(
          padding: EdgeInsets.only(right: SizeConfig.widthMultiplier! * 3,),
          child: GestureDetector(
            onTap: () {
              actionButton();
              textEditingController.clear();
            },
            child: Text(
              'Close',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.textMultiplier! * 2,
              ),
            ),
          ),
        ),
      )
    ];
    search = widgetsList[0];
    actionWidget = widgetsList[2];
    isPressed = false;
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
