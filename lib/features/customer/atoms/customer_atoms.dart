import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({
    super.key,
    required this.size,
    this.icon = FluentIcons.person_24_regular,
  });

  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return UserAvatarAtom(
      size: size,
      icon: icon,
    );
  }
}

class CustomerTitle extends StatelessWidget {
  const CustomerTitle({
    super.key,
    required this.text,
    this.fontSize = 20,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TitleAtom(
      text: text,
      level: TitleLevel.h2,
    );
  }
}

class CustomerSubtitle extends StatelessWidget {
  const CustomerSubtitle({
    super.key,
    required this.text,
    this.fontSize = 16,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SubtitleAtom(
      text: text,
      variant: SubtitleVariant.description,
      fontSize: fontSize,
    );
  }
}

class CustomerSectionTitle extends StatelessWidget {
  const CustomerSectionTitle({
    super.key,
    required this.text,
    this.fontSize = 18,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TitleAtom(
      text: text,
      level: TitleLevel.section,
    );
  }
}

class CustomerIcon extends StatelessWidget {
  const CustomerIcon({
    super.key,
    required this.icon,
    this.size = 20,
  });

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconAtom(
      icon: icon,
      size: size,
    );
  }
}

class CustomerContainer extends StatelessWidget {
  const CustomerContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.card,
      padding: padding,
      child: child,
    );
  }
}
