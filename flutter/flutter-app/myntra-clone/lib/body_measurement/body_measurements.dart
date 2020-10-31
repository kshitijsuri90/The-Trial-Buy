
class BodyMeasurement {
  final double height;
  final double width;
  BodyMeasurement({this.height,this.width});
  factory BodyMeasurement.fromJson(Map<String, dynamic> json) {
    return BodyMeasurement(
      height: json['height'],
      width: json['width'],
    );
  }
}