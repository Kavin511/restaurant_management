import 'package:flutter/material.dart';

class MenuDescTile extends StatelessWidget {
  MenuDescTile({
    Key key,
    this.foodName,
    this.foodDesc,
    this.price,
    this.foodType,
    this.availabiliy,
  }) : super(key: key);
  final String foodName;
  final String foodDesc;
  final String price;
  final String foodType;
  final String availabiliy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$foodName',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$foodDesc',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                price != null ? "Price is ₹ $price" : "Price not available",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$foodType ',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      children: [
                    TextSpan(
                        text: availabiliy == "true"
                            ? "Available now"
                            : "Not available currently"),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Icon(
                        Icons.circle,
                        color:
                            availabiliy == "true" ? Colors.green : Colors.red,
                        size: 15,
                      ),
                    ))
                  ]))
            ],
          ),
        ),
      ],
    );
  }
}
