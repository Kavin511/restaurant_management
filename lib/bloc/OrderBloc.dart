import 'dart:async';

import 'package:restaurant_app/Model/OrderModal.dart';
import 'package:restaurant_app/db/Networking/OrderNetworking/OrderResponse.dart';
import 'package:restaurant_app/db/Repository/OrderRepository.dart';

class OrderBloc {
  OrderRepository _orderRepository;
  StreamController _controller;

  StreamSink<OrderApiResponse<List<OrderModal>>> get orderListSink =>
      _controller.sink;

  Stream<OrderApiResponse<List<OrderModal>>> get orderListStream =>
      _controller.stream;

  OrderBloc() {
    _controller = StreamController<OrderApiResponse<List<OrderModal>>>();
    _orderRepository = OrderRepository();
    fetchOrder();
  }

  fetchOrder() async {
    orderListSink.add(OrderApiResponse.loading('Getting order details'));
    try {
      List<OrderModal> orderList = await _orderRepository.getOrder();
      print(orderList);
      orderListSink.add(OrderApiResponse.completed(orderList));
    } catch (e) {
      orderListSink.add(OrderApiResponse.error('Error occurred'));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
  }
}
