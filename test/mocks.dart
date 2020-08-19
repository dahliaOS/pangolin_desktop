import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:hive/src/box/box_impl.dart';

///If an UnimplementedError occurs here,
///you need to add a function here that
///operates on _store.
class BoxMock<E> extends Fake implements Box<E> {
  var _store = {};
  Future<void> put(dynamic key, E value) async {
    _store[key] = value;
  }
  E get(dynamic key, {E defaultValue}) => 
  _store.containsKey(key) 
  ? _store[key] ?? defaultValue 
  : defaultValue;
}