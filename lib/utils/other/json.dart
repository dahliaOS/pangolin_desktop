abstract class JsonType<T> {
  const JsonType();

  T? validate(Object? value) {
    if (value == null) return null;

    return validateForType<T>(value);
  }

  static T validateForType<T>(Object value, [String? name]) {
    if (value is! T) throwForType<T>(value);

    return value as T;
  }

  static Never throwForType<T>(Object value, [String? name]) {
    throw JsonTypeException(
      "The value '$value' ${name != null ? "for field $name" : ""} does not conform to the requested type $T",
    );
  }
}

class JsonObject extends JsonType<Map<String, dynamic>> {
  const JsonObject({required this.fields});
  final List<JsonObjectField<dynamic>> fields;

  @override
  Map<String, dynamic>? validate(Object? value) {
    if (value == null) return null;

    final validatedMap = JsonType.validateForType<Map<dynamic, dynamic>>(value);
    final Map<String, dynamic> finalMap;

    try {
      finalMap = validatedMap.cast<String, dynamic>();
    } catch (e) {
      JsonType.throwForType<Map<String, dynamic>>(value);
    }

    final result = <String, dynamic>{};
    for (final field in fields) {
      result[field.name] = field.validate(finalMap[field.name]);
    }

    return result;
  }
}

class JsonObjectWithTransformer<R> extends JsonType<R> {
  const JsonObjectWithTransformer({
    required this.fields,
    required this.transformer,
  });
  final List<JsonObjectField<dynamic>> fields;
  final JsonTransformer<Map<String, dynamic>, R> transformer;

  @override
  R? validate(Object? value) {
    final object = JsonObject(fields: fields);
    final validated = object.validate(value);

    if (validated == null) return null;

    final transformed = transformer(validated);
    return transformed;
  }
}

class JsonObjectField<T> {
  const JsonObjectField({
    required this.name,
    required this.type,
    this.required = false,
  });
  final String name;
  final JsonType<T> type;
  final bool required;

  T? validate(Object? value) {
    if (value == null) {
      if (required) {
        throw JsonException("The param '$name' was required");
      }

      return null;
    }

    return type.validate(value);
  }
}

class JsonArray extends JsonType<List<dynamic>> {
  const JsonArray({required this.type});
  final JsonType<dynamic> type;

  @override
  List<dynamic>? validate(Object? value) {
    if (value == null) return null;

    final validatedList = JsonType.validateForType<List<dynamic>>(value);
    final List<dynamic> finalList;

    try {
      finalList = validatedList.cast<dynamic>();
    } catch (e) {
      JsonType.throwForType<List<dynamic>>(value);
    }

    return finalList.map(type.validate).toList();
  }
}

class JsonConstant<T> extends JsonType<T> {
  const JsonConstant({this.validator});
  final JsonValidator<T>? validator;

  @override
  T? validate(Object? value) {
    final superVal = super.validate(value);

    if (superVal == null) return null;

    validateForValidator<T>(superVal, validator);

    return superVal;
  }

  static void validateForValidator<T>(
    T value,
    JsonValidator<T>? validator,
  ) {
    if (validator == null) return;

    if (!validator(value)) {
      throw JsonException('The validator for value $value failed');
    }
  }
}

class JsonNumber extends JsonConstant<num> {
  const JsonNumber({super.validator});
}

class JsonString extends JsonConstant<String> {
  const JsonString({super.validator});
}

class JsonBoolean extends JsonConstant<bool> {
  const JsonBoolean({super.validator});
}

class JsonConstantWithTransformer<T, R> extends JsonType<R> {
  const JsonConstantWithTransformer({
    required this.type,
    required this.transformer,
  });
  final JsonConstant<T> type;
  final JsonTransformer<T, R> transformer;

  @override
  R? validate(Object? value) {
    final validated = type.validate(value);

    if (validated == null) return null;

    final transformed = transformer(validated);
    return transformed;
  }
}

class JsonEither extends JsonType<dynamic> {
  const JsonEither(this.types);
  final Set<JsonType<dynamic>> types;

  @override
  dynamic validate(Object? value) {
    for (final type in types) {
      try {
        final dynamic validated = type.validate(value);
        return validated;
      } on JsonTypeException {
        continue;
      }
    }

    throw JsonTypeException(
      "The value '$value' does not conform to any type defined",
    );
  }
}

typedef JsonValidator<T> = bool Function(T value);
typedef JsonTransformer<T, R> = R Function(T value);

class JsonException implements Exception {
  const JsonException([this.message]);
  final String? message;

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class JsonTypeException extends JsonException {
  const JsonTypeException([super.message]);
}
