import 'package:flutter/material.dart';

class ListOfFood extends StatelessWidget {
  final int prix;
  final String nom;
  final String image;
  final Function adding;
  int quantity;

  ListOfFood({this.image, this.nom, this.prix, this.adding, this.quantity = 1});
  void incremantQuantity() {
    this.quantity = quantity + 1;
  }

  void decremantQuantity() {
    this.quantity = quantity - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 35,
                horizontal: 20,
              ),
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueGrey
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 110,
                    child: Image.network(image),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontFamily: 'slabo',
                      ),
                      children: [
                        TextSpan(
                          text: nom,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'DA $prix',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: "arial",
                          ),
                        ),
                      ),
                      RaisedButton(
                       child: Icon(Icons.add),
                        onPressed: adding,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      
      
    );
  }
}
