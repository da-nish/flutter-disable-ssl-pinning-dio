class DemoResponse {
  String message;

  DemoResponse({
    required this.message,
  });

  factory DemoResponse.fromJson(Map<String, dynamic> json) => DemoResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
