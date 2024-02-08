class Transcation {
  final String data;
  final String variable;
  final String transcationTime;

  Transcation({
    required this.data,
    required this.variable,
    required this.transcationTime,
  });

  factory Transcation.fromJson(Map<String, dynamic> json) {
    return Transcation(
      data: json['amount'] ?? 0,
      variable: json['transactiontype'] ?? '',
      transcationTime: json['transactiondate'] ?? '',
    );
  }
}
