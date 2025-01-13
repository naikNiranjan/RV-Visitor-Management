import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimation extends StatelessWidget {
  final VoidCallback? onAnimationComplete;

  const SuccessAnimation({
    super.key,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/success.json',
        width: 200,
        height: 200,
        repeat: false,
        onLoaded: (composition) {
          Future.delayed(composition.duration, () {
            onAnimationComplete?.call();
          });
        },
      ),
    );
  }
}
