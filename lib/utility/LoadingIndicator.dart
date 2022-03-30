import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:jsondemoproject/Colors/colors.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
        child: SpinKitCircle(
          color: WidgetColors.primaryColor,
          size: 50,
        ),
      );
}
