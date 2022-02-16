/*
Copyright 2021 The dahliaOS Authors

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

import 'package:pangolin/services/service.dart';

class ServiceManager {
  final List<Service> _registeredServices = [];
  final List<Service> _activeServices = [];

  void registerService(Service service) {}

  void startServices() {
    for (final Service service in _registeredServices) {
      if (service.isSupported()) {
        service.start();
        _activeServices.add(service);
      } else {
        // ignore: avoid_print
        print(
          "[Service Manager] Service: ${service.name} is not supported on this runtime",
        );
      }
    }
  }

  bool isActive(Service service) {
    return _activeServices.contains(service);
  }

  List<Service> get runningServices => _activeServices;
}
