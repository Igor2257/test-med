import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    super.key,
    this.trailingIcon,
    this.press,
    this.height,
    this.paddingInner,
    this.paddingOut,
    this.width,
    this.hoverColor,
    this.border,
    this.borderRadius,
    required this.text,
    required this.leadingIconPath,
    this.onHover,
    this.onLongPress,
    this.isOnlyText = false,
    this.isOnlyIcon = false,
    this.textStyle,
    required this.isSelected,
  });

  final String leadingIconPath;
  final String text;
  final TextStyle? textStyle;
  final Function()? press, onLongPress;
  final Function(bool)? onHover;
  final double? height;
  final EdgeInsets? paddingInner, paddingOut;
  final double? width;
  final Color? hoverColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget? trailingIcon;
  final bool isOnlyText;
  final bool isSelected;
  final bool isOnlyIcon;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isHover = false;
  bool isOnlyRead = false;

  @override
  void initState() {
    isOnlyRead = widget.isOnlyText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.paddingOut ?? const EdgeInsets.all(16),
      child: Container(
        height: widget.height ?? 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: widget.isSelected
              ? AppColors.primary
              : isHover
                  ? AppColors.primary.withOpacity(0.4)
                  : null,
        ),
        child: InkWell(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          onTap: widget.press,
          hoverColor: widget.isOnlyText
              ? Colors.transparent
              : widget.hoverColor ?? AppColors.secondary.withOpacity(0.5),
          onLongPress: widget.onLongPress,
          onHover: (value) {
            setState(() {
              isHover = value;
            });
            if (widget.onHover != null) {
              widget.onHover!(value);
            }
          },
          child: Container(
            padding: widget.paddingInner ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
              border: widget.border,
            ),
            child: Flex(
              direction: Axis.horizontal, // Минимальная ширина
              children: [
                if (!widget.isOnlyText)
                  Container(
                    height: (widget.height ?? 50) -
                        (widget.paddingInner?.top ?? 10) -
                        (widget.paddingInner?.bottom ?? 10),
                    width: (widget.height ?? 50) -
                        (widget.paddingInner?.top ?? 10) -
                        (widget.paddingInner?.bottom ?? 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ((widget.isOnlyText == false) && isHover)
                          ? Colors.transparent
                          : Colors.grey.shade300.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: SvgPicture.asset(widget.leadingIconPath, height: 24),
                  ),
                if (!widget.isOnlyIcon) const SizedBox(width: 20),
                if (!widget.isOnlyIcon)
                  Text(
                    widget.text,
                    style: isOnlyRead
                        ? TextStyle(
                            color: isHover ? AppColors.secondary : Colors.black,
                            decoration: isHover
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          )
                        : widget.textStyle,
                  ),
                if (widget.trailingIcon != null) const Spacer(),
                if (widget.trailingIcon != null) widget.trailingIcon!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
