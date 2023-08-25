// class OrderResponse {
//   final OrderNode node;
//
//   OrderResponse({required this.node});
//
//   factory OrderResponse.fromJson(Map<String, dynamic> json) {
//     return OrderResponse(
//       node: OrderNode.fromJson(json['node']),
//     );
//   }
// }
//
// class OrderNode {
//   final Orders orders;
//
//   OrderNode({required this.orders});
//
//   factory OrderNode.fromJson(Map<String, dynamic> json) {
//     return OrderNode(
//       orders: Orders.fromJson(json['orders']),
//     );
//   }
// }
//
// class Orders {
//   final List<OrderEdge> edges;
//
//   Orders({required this.edges});
//
//   factory Orders.fromJson(Map<String, dynamic> json) {
//     return Orders(
//       edges: (json['edges'] as List)
//           .map((i) => OrderEdge.fromJson(i))
//           .toList(),
//     );
//   }
// }
//
// class OrderEdge {
//   final Order node;
//
//   OrderEdge({required this.node});
//
//   factory OrderEdge.fromJson(Map<String, dynamic> json) {
//     return OrderEdge(
//       node: Order.fromJson(json['node']),
//     );
//   }
// }
//
// class Order {
//   final String id;
//   final String name;
//   final PriceSet totalPriceSet;
//   final LineItems lineItems;
//
//   Order({
//     required this.id,
//     required this.name,
//     required this.totalPriceSet,
//     required this.lineItems,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'],
//       name: json['name'],
//       totalPriceSet: PriceSet.fromJson(json['totalPriceSet']),
//       lineItems: LineItems.fromJson(json['lineItems']),
//     );
//   }
// }
//
// class PriceSet {
//   final Money shopMoney;
//
//   PriceSet({required this.shopMoney});
//
//   factory PriceSet.fromJson(Map<String, dynamic> json) {
//     return PriceSet(
//       shopMoney: Money.fromJson(json['shopMoney']),
//     );
//   }
// }
//
// class Money {
//   final String amount;
//   final String currencyCode;
//
//   Money({required this.amount, required this.currencyCode});
//
//   factory Money.fromJson(Map<String, dynamic> json) {
//     return Money(
//       amount: json['amount'],
//       currencyCode: json['currencyCode'],
//     );
//   }
// }
//
// class LineItems {
//   final List<ItemEdge> edges;
//
//   LineItems({required this.edges});
//
//   factory LineItems.fromJson(Map<String, dynamic> json) {
//     return LineItems(
//       edges: (json['edges'] as List)
//           .map((i) => ItemEdge.fromJson(i))
//           .toList(),
//     );
//   }
// }
//
// class ItemEdge {
//   final Item node;
//
//   ItemEdge({required this.node});
//
//   factory ItemEdge.fromJson(Map<String, dynamic> json) {
//     return ItemEdge(
//       node: Item.fromJson(json['node']),
//     );
//   }
// }
//
// class Item {
//   final String title;
//   final int quantity;
//
//   Item({required this.title, required this.quantity});
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       title: json['title'],
//       quantity: json['quantity'],
//     );
//   }
// }