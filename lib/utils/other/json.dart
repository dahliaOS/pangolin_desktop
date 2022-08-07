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
  final List<JsonObjectField> fields;

  const JsonObject({required this.fields});

  @override
  Map<String, dynamic>? validate(Object? value) {
    if (value == null) return null;

    final Map validatedMap = JsonType.validateForType<Map>(value);
    final Map<String, dynamic> finalMap;

    try {
      finalMap = validatedMap.cast<String, dynamic>();
    } catch (e) {
      JsonType.throwForType<Map<String, dynamic>>(value);
    }

    final Map<String, dynamic> result = {};
    for (final JsonObjectField field in fields) {
      result[field.name] = field.validate(finalMap[field.name]);
    }

    return result;
  }
}

class JsonObjectWithTransformer<R> extends JsonType<R> {
  final List<JsonObjectField> fields;
  final JsonTransformer<Map<String, dynamic>, R> transformer;

  const JsonObjectWithTransformer({
    required this.fields,
    required this.transformer,
  });

  @override
  R? validate(Object? value) {
    final JsonObject object = JsonObject(fields: fields);
    final Map<String, dynamic>? validated = object.validate(value);

    if (validated == null) return null;

    final R transformed = transformer(validated);
    return transformed;
  }
}

class JsonObjectField<T> {
  final String name;
  final JsonType<T> type;
  final bool required;

  const JsonObjectField({
    required this.name,
    required this.type,
    this.required = false,
  });

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
  final JsonType type;

  const JsonArray({required this.type});

  @override
  List<dynamic>? validate(Object? value) {
    if (value == null) return null;

    final List validatedList = JsonType.validateForType<List>(value);
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
  final JsonValidator<T>? validator;

  const JsonConstant({this.validator});

  @override
  T? validate(Object? value) {
    final T? superVal = super.validate(value);

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
      throw JsonException("The validator for value $value failed");
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
  final JsonConstant<T> type;
  final JsonTransformer<T, R> transformer;

  const JsonConstantWithTransformer({
    required this.type,
    required this.transformer,
  });

  @override
  R? validate(Object? value) {
    final T? validated = type.validate(value);

    if (validated == null) return null;

    final R transformed = transformer(validated);
    return transformed;
  }
}

class JsonEither extends JsonType<dynamic> {
  final Set<JsonType> types;

  const JsonEither(this.types);

  @override
  dynamic validate(Object? value) {
    for (final JsonType type in types) {
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
  final String? message;

  const JsonException([this.message]);

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class JsonTypeException extends JsonException {
  const JsonTypeException([super.message]);
}
