import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  final Color variant;
  final Color labelVariant;
  final String placeholder;
  //style?: StyleProp<ViewStyle>;
  //inputStyle?: StyleProp<ViewStyle>;
  final String label;
  //labelStyle?: StyleProp<ViewStyle>;
  //onChange?: (value: string) => void;
  //type?: "password" | "none" | "emailAddress" | "username" | "newPassword";

  //const MyCustomForm({Key? key}) : super(key: key);
  const Form({
    super.key,
    this.color = const Color(0xFFFFE306),
  });

  @override
  State<Form> createState() => FormState();
}

class FormState extends State<Form> {
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}
/*
class Bird extends StatefulWidget {
  const Bird({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: widget.child,
    );
  }
}*/