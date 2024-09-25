import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utills/assets_path.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    Size sizescreen =  MediaQuery.of(context).size;
    return Stack(
        children:[
          SvgPicture.asset(AssetsPath.backgroudSvg,
            width:sizescreen.width,
            height:sizescreen.height,
          ),
          SafeArea(child: child),
        ]
    );
  }
}
