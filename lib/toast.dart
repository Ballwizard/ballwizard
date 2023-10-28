import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart' show ColorPalette, Toast, ToastVariant;
import 'package:flutter/material.dart';

class ToastComponent extends StatefulWidget {
  final Toast toast;
  const ToastComponent({super.key, required this.toast});

  @override
  ToastState createState() => ToastState();
}

class ToastState extends State<ToastComponent> {
  @override
  Widget build(BuildContext context) {
    final Color color = widget.toast.variant.color();
    final IconData icon = widget.toast.variant.icon();

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
            height: 45,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: ColorPalette.light,
                    child: Row(
                      children: [
                        FractionallySizedBox(
                          heightFactor: 1,
                          child: SizedBox(
                            child: ColoredBox(
                              color: color,
                              child: Icon(
                                icon,
                                color: ColorPalette.light,
                                size: 32,
                              ),
                            ),
                            width: 48,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            child: Text(
                              widget.toast.value,
                              style: Fonts.small,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        )
                      ],
                    ),
                  )),
            )),
      ),
    );
  }
}

/*
Material(
                color: widget.variant.color(),
                child: InkWell(
                    onTap: widget.onClick,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(widget.title,
                          style: TextStyle(
                              color: useLightFont
                                  ? ColorPalette.light
                                  : ColorPalette.dark)),
                    ))),
 */
