import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jsondemoproject/Colors/colors.dart';
import 'package:jsondemoproject/model/post_dto.dart';
import 'package:jsondemoproject/screen/read_post.dart';

import '../screen/new_post.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */

class UIUtil {
  static loadMoreData() {
    return const Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Center(
          child: CircularProgressIndicator(
            color: WidgetColors.primaryColor,
          ),
        ));
  }

  static nothingToLoad() {
    return Container();
    /* return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.amber,
      child: Center(
        child: Text('You have fetched all of the content'),
      ),
    );*/
  }

  static toastPrint(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.grey,
        fontSize: 16.0);
  }

  static getText(String value, double fontsize) {
    return Text(
      value,
      style: TextStyle(
          fontSize: fontsize,
          fontWeight: FontWeight.w400,
          color: Colors.black87),
    );
  }

  static height(double value) {
    return SizedBox(
      height: value,
    );
  }

  static PostPage(BuildContext context, PostDTO? postDTO) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPostPage(
                  postDTO: postDTO,
                )));
  }

  static readPage(BuildContext context, PostDTO? postDTO) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReadPostPage(
                  postDTO: postDTO,
                )));
  }

  static int getValue(int? value) {
    if (value != null) {
      return value;
    }
    return 0;
  }

  static Widget makeInputTitle(titleController, {label, obsureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: titleController,
          obscureText: obsureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  static nodatafound(String msg) {
    return Center(
      child: Text(
        msg,
      ),
    );
  }
}
