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
import "dart:math";

T getRandomElement<T>(List<T> list) {
  final random = new Random();
  var i = random.nextInt(list.length);
  return list[i];
}

String systemInfoTip() {
  var list = [
    'Want to customize the system? Customization options can be found under Settings! Click here to learn more.',
    'Need to run an app? Graft can be used virtualize operating systems and applications! Click here to learn more.',
    'Experiencing issues? Reports can be found in System Logs! Click here to learn more.'
  ];
  var element = getRandomElement(list);
  return element;
}
