import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    hexString = hexString.replaceFirst('#', '');
    buffer.write(hexString);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class ColorUtils {
  static final primary = HexColor.fromHex("#DC0A2D");
  static final bug = HexColor.fromHex("#A7B723");
  static final dark = HexColor.fromHex("#75574C");
  static final dragon = HexColor.fromHex("#7037FF");
  static final electric = HexColor.fromHex("#F9CF30");
  static final fairy = HexColor.fromHex("#E69EAC");
  static final fighting = HexColor.fromHex("#C12239");
  static final fire = HexColor.fromHex("#F57D31");
  static final flying = HexColor.fromHex("#A891EC");
  static final ghost = HexColor.fromHex("#70559B");
  static final grass = HexColor.fromHex("#74CB48");
  static final ground = HexColor.fromHex("#DEC16B");
  static final ice = HexColor.fromHex("#9AD6DF");
  static final poison = HexColor.fromHex("#A43E9E");
  static final psychic = HexColor.fromHex("#FB5584");
  static final rock = HexColor.fromHex("#B69E31");
  static final steel = HexColor.fromHex("#B7B9D0");
  static final water = HexColor.fromHex("#6493EB");
  static final grayscaleDark = HexColor.fromHex("#212121");
  static final grayscaleMedium = HexColor.fromHex("#666666");
  static final grayscaleLight = HexColor.fromHex("#E0E0E0");
  static final background = HexColor.fromHex("#EFEFEF");
  static final white = HexColor.fromHex("#FFFFFF");
  static final wireframe = HexColor.fromHex("#B8B8B8");
}

enum ColorType {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  poison,
  psychic,
  rock,
  steel,
  water,
  none,
}

extension ColorTypeExtension on ColorType {
  Color get color {
    switch (this) {
      case ColorType.bug:
        return ColorUtils.bug;
      case ColorType.dark:
        return ColorUtils.dark;
      case ColorType.dragon:
        return ColorUtils.dragon;
      case ColorType.electric:
        return ColorUtils.electric;
      case ColorType.fairy:
        return ColorUtils.fairy;
      case ColorType.fighting:
        return ColorUtils.fighting;
      case ColorType.fire:
        return ColorUtils.fire;
      case ColorType.flying:
        return ColorUtils.flying;
      case ColorType.ghost:
        return ColorUtils.ghost;
      case ColorType.grass:
        return ColorUtils.grass;
      case ColorType.ground:
        return ColorUtils.ground;
      case ColorType.ice:
        return ColorUtils.ice;
      case ColorType.poison:
        return ColorUtils.poison;
      case ColorType.psychic:
        return ColorUtils.psychic;
      case ColorType.rock:
        return ColorUtils.rock;
      case ColorType.steel:
        return ColorUtils.steel;
      case ColorType.water:
        return ColorUtils.water;
      case ColorType.none:
        return ColorUtils.wireframe;
    }
  }
}

Color colorStringToType(String? colorString) {
  if (colorString == null) return ColorType.none.color;
  try {
    return ColorType.values
        .firstWhere((e) => e.name == colorString.toLowerCase())
        .color;
  } catch (_) {
    return ColorType.none.color;
  }
}
