import 'package:flutter/material.dart';

class Paddings {
  static const  p2 = EdgeInsets.all(0);
  static const  p4 = EdgeInsets.all(2);
  static const  p6 = EdgeInsets.all(4);
  static const  p8 = EdgeInsets.all(6);
  static const  p12 = EdgeInsets.all(10);
  static const  p10 = EdgeInsets.all(8);
  static const  p16 = EdgeInsets.all(14);
  static const  p20 = EdgeInsets.all(18);
  static const  p24 = EdgeInsets.all(22);
  static const  p28 = EdgeInsets.all(26);
  static const  p30 = EdgeInsets.all(28);
  static const  p32 = EdgeInsets.all(30);
  static const  p36 = EdgeInsets.all(32);
  static const  p40 = EdgeInsets.all(40);
  static const  p44 = EdgeInsets.all(44);
  static const  p48 = EdgeInsets.all(48);
  static const  p52 = EdgeInsets.all(52);
  static const  p56 = EdgeInsets.all(56);
}

extension Symmetric on EdgeInsets {
  EdgeInsets get horizontally {
    return EdgeInsets.symmetric(horizontal: left);
  }

  EdgeInsets get vertically {
    return EdgeInsets.symmetric(vertical: top);
  }

  EdgeInsets get onlyLeft {
    return EdgeInsets.only(left: left);
  }

  EdgeInsets get onlyRight {
    return EdgeInsets.only(right: right);
  }

  EdgeInsets get onlyBottom {
    return EdgeInsets.only(bottom: bottom);
  }

  EdgeInsets get onlyTop {
    return EdgeInsets.only(top: top);
  }

  EdgeInsets get exceptTop {
    return EdgeInsets.only(
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  EdgeInsets get exceptBottom {
    return EdgeInsets.only(
      top: top,
      left: left,
      right: right,
    );
  }
}
