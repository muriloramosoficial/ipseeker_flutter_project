class IpModel {
  IpModel({
    required this.ip,
  });
  late final String ip;

  IpModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ip'] = ip;
    return _data;
  }
}
