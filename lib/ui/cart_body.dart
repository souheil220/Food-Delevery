import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/cartListBloc.dart';
import 'list_of_food.dart';
import 'restaurants_menu.dart';
import 'cart_list_item.dart';
import 'drag_target_widget.dart';

class CartBody extends StatefulWidget {
  final List<ListOfFood> listOfFood;
  static double totalAmount = 0.0;

  CartBody(this.listOfFood);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
        child: Column(
          children: <Widget>[
            CustumAppBar(),
            title(),
            Expanded(
              flex: 1,
              child: widget.listOfFood.length > 0
                  ? foodItemList()
                  : noItemContaner(),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/img/delevry_guy.jpg'),
                  width: 80.0,
                  height: 100.0,
                ),
                Text("Delevery Price"),
                Text("DA ${ widget.listOfFood.length > 0 ? RestaurantsMenu.deleveryPrice.toStringAsFixed(0) : 0}"),
              ],
            )),
          ],
        ),
      ),

    );
  }

  Container noItemContaner() {
    return Container(
      child: Center(
        child: Text(
          "No Items Left in the Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: widget.listOfFood.length,
      itemBuilder: (BuildContext context, int index) {
        return CartListItem(
          listOfFood: widget.listOfFood[index],
        );
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "My",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
          Text(
            "Order",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class CustumAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
              child: Icon(
                CupertinoIcons.back,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        DragTargetWidget(),
      ],
    );
  }
}
