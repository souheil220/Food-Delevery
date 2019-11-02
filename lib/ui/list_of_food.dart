import 'package:flutter/material.dart';

class ListOfFood extends StatelessWidget {
  final int prix;
  final String nom;
  final String image;

  const ListOfFood({
    this.image,
    this.nom,
    this.prix,
  });

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
            width: 225,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
             // color: Colors.red,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 150,
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
                  height: 1,
                ),
                Row(
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
