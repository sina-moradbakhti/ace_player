class ApicModel {
  final String mime;
  final String base64Data;

  ApicModel({required this.mime, required this.base64Data});

  factory ApicModel.fromJson(Map<String, dynamic> json) =>
      ApicModel(mime: json['mime'], base64Data: json['base64']);
}
