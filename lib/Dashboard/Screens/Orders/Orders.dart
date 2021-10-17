import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/OrderBloc.dart';
import 'package:restaurant_app/db/Networking/OrderNetworking/OrderResponse.dart';

import 'OrderList.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  OrderBloc orderBloc;

  @override
  void initState() {
    super.initState();
    orderBloc = OrderBloc();
    orderBloc.fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        print('hel');
        return orderBloc.fetchOrder();
      },
      child: StreamBuilder(
          stream: orderBloc.orderListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  print('loading orders');
                  return Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Loading orders'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                  break;
                case Status.COMPLETED:
                  return OrderList(orderList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return new Container(
                    child: Center(child: Text('No orders currently')),
                  );
              }
            }
            return Container();
          }),
    );
  }
}
