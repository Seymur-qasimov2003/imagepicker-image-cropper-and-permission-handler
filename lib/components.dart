import 'package:flutter/material.dart';

class ContanierComponent extends StatefulWidget {
  const ContanierComponent({Key? key}) : super(key: key);

  @override
  State<ContanierComponent> createState() => _ContanierComponentState();
}

class _ContanierComponentState extends State<ContanierComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Upload Image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
