import 'package:flutter/material.dart';
import 'package:search/utils/size_config.dart';

///This is the search bar widget that has been used in all types.
class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, required this.textEditingController, this.passedFunction})
      : super(key: key);
  final TextEditingController textEditingController;
  final dynamic passedFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier! * 2,
        vertical: SizeConfig.heightMultiplier! * 0.5,
      ),
      height: SizeConfig.heightMultiplier! * 5,
      width: SizeConfig.widthMultiplier! * 70,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onTap: passedFunction,
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.textMultiplier! * 2.5,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white12,
            fontSize: SizeConfig.textMultiplier! * 2.5,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier! * 1,
          ),
          icon: Icon(
            Icons.search,
            size: SizeConfig.imageSizeMultiplier! * 8,
            color: Colors.white12,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              textEditingController.clear();
            },
            child: Icon(
              Icons.cancel,
              color: Colors.white12,
              size: SizeConfig.imageSizeMultiplier! * 8,
            ),
          ),
        ),
      ),
    );
  }
}
