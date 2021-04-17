import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor: Colors.purple,
      this.textColor: Colors.white,
      this.radius: 16,
      this.height: 40,
      this.buttonIcon,
      @required this.onPressed})
      : assert(buttonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (buttonIcon != null) ...[
                buttonIcon,
                Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
                Opacity(opacity: 0, child: buttonIcon),
              ],
              if (buttonIcon == null) ...[
                Container(),
                Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
                Container(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

/*
buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                style: TextStyle(
                  color: textColor
                ),
              ),
              Opacity(
                opacity: 0,
                  child: buttonIcon
              ),
* */
