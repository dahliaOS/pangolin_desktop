//finds data
class Shape{
  String appName;
  Property property;

  Shape({
    this.appName,
    this.property
});

  factory Shape.fromJson(Map<String, dynamic> parsedJson){
    return Shape(
      appName: parsedJson['shape_name'],
      property: Property.fromJson(parsedJson['property'])
    );
  }
}

class Property{
  double width;
  double breadth;

  Property({
    this.width,
    this.breadth
});

  factory Property.fromJson(Map<String, dynamic> json){
    return Property(
      width: json['width'],
      breadth: json['breadth']
    );
  }
}