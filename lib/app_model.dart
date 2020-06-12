/*
Copyright 2019 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
