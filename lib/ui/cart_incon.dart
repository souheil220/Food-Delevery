import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final int length;
  const CartIcon(this.length);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
              Container(
      height: 40,
         width: 40,
        margin: EdgeInsets.only(right: 30),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.circular(50),
        ),
        //  child: Text(length.toString()),

       ),
   Positioned( 
     
            left:1,
            bottom: 1,
     child:  Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.shopping_cart,),
            ),
     
   ),
           
            
              Positioned(
              
              right: 1,
              child:
                 Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Container(
             
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
                
            ),
          ],
        
    );
  }
}
