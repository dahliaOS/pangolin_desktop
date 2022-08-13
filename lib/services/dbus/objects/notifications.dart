// This file was generated using the following command and may be overwritten.
// dart-dbus generate-object lib/services/dbus/specifications/org.freedesktop.Notifications.xml

import 'package:dbus/dbus.dart';

class NotificationsBase extends DBusObject {
  /// Creates a new object to expose on [path].
  NotificationsBase({DBusObjectPath path = DBusObjectPath.root}) : super(path);

  /// Implementation of org.freedesktop.Notifications.GetServerInformation()
  Future<DBusMethodResponse> doGetServerInformation() async {
    return DBusMethodErrorResponse.failed(
      'org.freedesktop.Notifications.GetServerInformation() not implemented',
    );
  }

  /// Implementation of org.freedesktop.Notifications.GetCapabilities()
  Future<DBusMethodResponse> doGetCapabilities() async {
    return DBusMethodErrorResponse.failed(
      'org.freedesktop.Notifications.GetCapabilities() not implemented',
    );
  }

  /// Implementation of org.freedesktop.Notifications.CloseNotification()
  Future<DBusMethodResponse> doCloseNotification(int id) async {
    return DBusMethodErrorResponse.failed(
      'org.freedesktop.Notifications.CloseNotification() not implemented',
    );
  }

  /// Implementation of org.freedesktop.Notifications.Notify()
  Future<DBusMethodResponse> doNotify(
    String appName,
    int replaces,
    String icon,
    String summary,
    String body,
    List<String> actions,
    Map<String, DBusValue> hints,
    int timeout,
  ) async {
    return DBusMethodErrorResponse.failed(
      'org.freedesktop.Notifications.Notify() not implemented',
    );
  }

  @override
  List<DBusIntrospectInterface> introspect() {
    return [
      DBusIntrospectInterface(
        'org.freedesktop.Notifications',
        methods: [
          DBusIntrospectMethod(
            'GetServerInformation',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'return_name',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'return_vendor',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'return_version',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'return_spec_version',
              )
            ],
          ),
          DBusIntrospectMethod(
            'GetCapabilities',
            args: [
              DBusIntrospectArgument(
                DBusSignature('as'),
                DBusArgumentDirection.out,
                name: 'return_caps',
              )
            ],
          ),
          DBusIntrospectMethod(
            'CloseNotification',
            args: [
              DBusIntrospectArgument(
                DBusSignature('u'),
                DBusArgumentDirection.in_,
                name: 'id',
              )
            ],
          ),
          DBusIntrospectMethod(
            'Notify',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'app_name',
              ),
              DBusIntrospectArgument(
                DBusSignature('u'),
                DBusArgumentDirection.in_,
                name: 'id',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'icon',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'summary',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'body',
              ),
              DBusIntrospectArgument(
                DBusSignature('as'),
                DBusArgumentDirection.in_,
                name: 'actions',
              ),
              DBusIntrospectArgument(
                DBusSignature('a{sv}'),
                DBusArgumentDirection.in_,
                name: 'hints',
              ),
              DBusIntrospectArgument(
                DBusSignature('i'),
                DBusArgumentDirection.in_,
                name: 'timeout',
              ),
              DBusIntrospectArgument(
                DBusSignature('u'),
                DBusArgumentDirection.out,
                name: 'return_id',
              )
            ],
          )
        ],
      )
    ];
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall methodCall) async {
    if (methodCall.interface == 'org.freedesktop.Notifications') {
      if (methodCall.name == 'GetServerInformation') {
        if (methodCall.values.isNotEmpty) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doGetServerInformation();
      } else if (methodCall.name == 'GetCapabilities') {
        if (methodCall.values.isNotEmpty) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doGetCapabilities();
      } else if (methodCall.name == 'CloseNotification') {
        if (methodCall.signature != DBusSignature('u')) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doCloseNotification(methodCall.values[0].asUint32());
      } else if (methodCall.name == 'Notify') {
        if (methodCall.signature != DBusSignature('susssasa{sv}i')) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doNotify(
          methodCall.values[0].asString(),
          methodCall.values[1].asUint32(),
          methodCall.values[2].asString(),
          methodCall.values[3].asString(),
          methodCall.values[4].asString(),
          methodCall.values[5].asStringArray().toList(),
          methodCall.values[6].asStringVariantDict(),
          methodCall.values[7].asInt32(),
        );
      } else {
        return DBusMethodErrorResponse.unknownMethod();
      }
    } else {
      return DBusMethodErrorResponse.unknownInterface();
    }
  }

  @override
  Future<DBusMethodResponse> getProperty(String interface, String name) async {
    if (interface == 'org.freedesktop.Notifications') {
      return DBusMethodErrorResponse.unknownProperty();
    } else {
      return DBusMethodErrorResponse.unknownProperty();
    }
  }

  @override
  Future<DBusMethodResponse> setProperty(
    String interface,
    String name,
    DBusValue value,
  ) async {
    if (interface == 'org.freedesktop.Notifications') {
      return DBusMethodErrorResponse.unknownProperty();
    } else {
      return DBusMethodErrorResponse.unknownProperty();
    }
  }
}
