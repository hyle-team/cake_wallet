class Destination {
  final int amount;     // transfered as string
  final String address;
  final String assetId;

  Destination(
      {required this.amount, required this.address, required this.assetId});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        amount: int.parse(json['amount'] as String),
        address: json['address'] as String,
        assetId: json['asset_id'] as String,
      );

  Map<String, dynamic> toJson() => {
    "amount": amount.toString(),
    "address": address,
    "asset_id": assetId,
  };
}
