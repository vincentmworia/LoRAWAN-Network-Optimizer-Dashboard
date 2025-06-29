import './decoded_payload.dart';
import './rx_metadata.dart';
import './settings.dart';

class UplinkMessage {
  String? sessionKeyId;
  int? fPort;
  int? fCnt;
  String? frmPayload;
  DecodedPayload? decodedPayload;
  RxMetadata? rxMetadata;
  Settings? settings;

  UplinkMessage({
    required this.sessionKeyId,
    required this.fPort,
    required this.fCnt,
    required this.frmPayload,
    required this.decodedPayload,
    required this.rxMetadata,
    required this.settings,
  });

  static UplinkMessage fromMap(Map<String, dynamic> json) => UplinkMessage(
    sessionKeyId: json['session_key_id'] as String,
    fPort: json['f_port'] as int,
    fCnt: json['f_cnt'] as int,
    frmPayload: json['frm_payload'] as String,
    decodedPayload: DecodedPayload.fromMap(json['decoded_payload']),
    rxMetadata: RxMetadata.fromListOfMap(json['rx_metadata']),
    settings: Settings.fromMap(json['settings']),
  );
}
