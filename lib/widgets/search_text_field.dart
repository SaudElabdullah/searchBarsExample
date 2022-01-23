import 'package:flutter/material.dart';
import 'package:search/utils/size_config.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, required this.textEditingController, this.onTap})
      : super(key: key);
  final TextEditingController textEditingController;
  final onTap;

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
        onTap: onTap,
        controller: textEditingController,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.textMultiplier! * 2.5,
        ),
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
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
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier! * 1,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white12,
            fontSize: SizeConfig.textMultiplier! * 2.5,
          ),
        ),
      ),
    );
  }
}
