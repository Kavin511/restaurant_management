import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Model/OrderModal.dart';
import 'package:restaurant_app/Services/Orders/Orders.dart';
import 'package:slimy_card/slimy_card.dart';

import '../../../../AppConstants.dart';

class OrderList extends StatefulWidget {
  List<OrderModal> orderList;

  OrderList({this.orderList});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    print("${widget.orderList} is pro");
    return Container(
      child: widget.orderList.length > 0
          ? ListView.builder(
              itemCount: widget.orderList.length,
              itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 2, bottom: 10),
                  child: SlimyCard(
                    topCardWidget: OrderCard(index),
                    topCardHeight: 150,
                    width: MediaQuery.of(context).size.width * .95,
                    color: kPrimaryColor,
                    bottomCardWidget: bottomCard(index),
                    bottomCardHeight: 180,
                    borderRadius: 16,
                  )))
          : Center(
              child: Text(
                'No orders currently',
                style: TextStyle(color: kTextColor),
              ),
            ),
    );
  }

  Widget bottomCard(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(kDefaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Delivery Location',
              style: TextStyle(
                  color: kTextLightColor,
                  // fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Address : ",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    widget.orderList[index].address,
                    style: TextStyle(color: kTextColor, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Pin code : ",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    widget.orderList[index].pinCode,
                    style: TextStyle(color: kTextColor, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "District : ",
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    widget.orderList[index].district,
                    style: TextStyle(color: kTextColor, fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.orderList[index].status == "Pending"
                      ? Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                iconSize: 30,
                                onPressed: () => {
                                      Get.snackbar(
                                          'Processing ', 'Changing status',
                                          snackPosition: SnackPosition.BOTTOM),
                                      OrderServices().updateStatus(
                                          widget.orderList[index].id,
                                          'Completed'),
                                      setState(() => {
                                            widget.orderList[index].status =
                                                "Completed",
                                          }),
                                    }),
                          ],
                        )
                      : Text(widget.orderList[index].status),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget OrderCard(int index) {
    return Container(
      height: MediaQuery.of(context).size.height * .17,
      margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "#Order id:" + widget.orderList[index].id,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: kTextLightColor,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/food.jpg'),
                    radius: 40,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: widget.orderList[index].menuItem.length * 20.0,
                        child: ListView.builder(
                            itemCount: widget.orderList[index].menuItem.length,
                            itemBuilder: (ctxt, i) => menuItem(index, i)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.orderList[index].status == 'Pending'
                            ? Icon(
                                Icons.access_time_outlined,
                                color: kSecondaryColor,
                              )
                            : widget.orderList[index].status == "Completed"
                                ? (Icon(
                                    Icons.check,
                                    color: Colors.green.withOpacity(.9),
                                  ))
                                : Icon(
                                    Icons.cancel,
                                    color: Colors.redAccent.withOpacity(.9),
                                  ),
                        Text(widget.orderList[index].status)
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container menuItem(int index, int i) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.orderList[index].menuItem[i].foodName + " - "),
          Text('\u{20B9}' + " ${widget.orderList[index].menuItem[i].price}"),
        ],
      ),
    );
  }
}
