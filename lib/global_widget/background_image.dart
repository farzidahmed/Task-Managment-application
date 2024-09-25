import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utills/assets_path.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key,  required this.child});
final Widget child;

  @override
  Widget build(BuildContext context) {

    Size sizescreen =  MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children:[
            Positioned.fill(
              child: SvgPicture.asset(AssetsPath.backgroudSvg,
                width:sizescreen.width,
                height:sizescreen.height,
                fit: BoxFit.cover
              ),
            ),
            SafeArea(child: child),
          ]
      ),
    );
  }
}
