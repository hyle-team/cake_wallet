import 'package:cw_zano/api/model/employed_entries.dart';
import 'package:cw_zano/api/model/subtransfer.dart';

class Transfer {
  final String comment;
  final EmployedEntries employedEntries;
  final int fee;
  final int height;
  final bool isMining;
  final bool isMixing;
  final bool isService;
  final String paymentId;
  final List<String> remoteAddresses;
  final List<String> remoteAliases;
  final bool showSender;
  final List<Subtransfer> subtransfers;
  final int timestamp;
  final int transferInternalIndex;
  final int txBlobSize;
  final String txHash;
  final int txType;
  final int unlockTime;

  Transfer({
    required this.comment,
    required this.employedEntries,
    required this.fee,
    required this.height,
    required this.isMining,
    required this.isMixing,
    required this.isService,
    required this.paymentId,
    required this.remoteAddresses,
    required this.remoteAliases,
    required this.showSender,
    required this.subtransfers,
    required this.timestamp,
    required this.transferInternalIndex,
    required this.txBlobSize,
    required this.txHash,
    required this.txType,
    required this.unlockTime,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        comment: json['comment'] as String? ?? '',
        employedEntries: EmployedEntries.fromJson(
            json['employed_entries'] as Map<String, dynamic>? ?? {}),
        fee: json['fee'] as int? ?? 0,
        height: json['height'] as int? ?? 0,
        isMining: json['is_mining'] as bool? ?? false,
        isMixing: json['is_mixing'] as bool? ?? false,
        isService: json['is_service'] as bool? ?? false,
        paymentId: json['payment_id'] as String? ?? '',
        remoteAddresses: json['remote_addresses'] == null ? [] :
            (json['remote_addresses'] as List<dynamic>).cast<String>(),
        remoteAliases: json['remote_aliases'] == null ? [] : (json['remote_aliases'] as List<dynamic>).cast<String>(),
        showSender: json['show_sender'] as bool? ?? false,
        subtransfers: (json['subtransfers'] as List<dynamic>? ?? [])
            .map((e) => Subtransfer.fromJson(e as Map<String, dynamic>))
            .toList(),
        timestamp: json['timestamp'] as int? ?? 0,
        transferInternalIndex: json['transfer_internal_index'] == null ? 0 : json['transfer_internal_index'] is double ? (json['transfer_internal_index'] as double).toInt() : json['transfer_internal_index'] as int,
        txBlobSize: json['tx_blob_size'] as int? ?? 0,
        txHash: json['tx_hash'] as String? ?? '',
        txType: json['tx_type'] as int? ?? 0,
        unlockTime: json['unlock_time'] as int? ?? 0,
      );
}
