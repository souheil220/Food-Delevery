import 'package:flutter/material.dart';
import 'package:hello_world/ui/list_of_food.dart';

class ItemContent extends StatelessWidget {
  final ListOfFood listOfFood;
  ItemContent({@required this.listOfFood});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: ClipRRect(
            
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              listOfFood.image,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
        ),
        Flexible(
                  child: RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: listOfFood.quantity.toString()),
                  TextSpan(text: " x "),
                  TextSpan(text: listOfFood.nom,),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text(
            "DA ${listOfFood.quantity * listOfFood.prix}",
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
