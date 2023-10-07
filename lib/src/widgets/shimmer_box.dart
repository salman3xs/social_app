import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          direction: ShimmerDirection.ltr,
          child: const Card(
            elevation: 1,
            child: SizedBox(
              height: 200,
            ),
          ),
        ));
  }
}
