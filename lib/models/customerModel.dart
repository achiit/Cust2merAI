class CustomerDetail {
  final int id;
  final String name;
  final String orderId;
  final String issue;
  final String priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool solved;
  CustomerDetail(
      {required this.id,
      required this.name,
      required this.orderId,
      required this.issue,
      required this.priority,
      required this.createdAt,
      required this.updatedAt,
      required this.solved});

  factory CustomerDetail.fromJson(Map<String, dynamic> json) {
    return CustomerDetail(
        id: json['id'],
        name: json['name'],
        orderId: json['order_id'],
        issue: json['issue'],
        priority: json['priority'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        solved: json['solved']);
  }
}
