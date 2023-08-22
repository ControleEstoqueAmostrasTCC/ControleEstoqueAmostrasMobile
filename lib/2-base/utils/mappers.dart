bool fromJsonBoolean(dynamic value) => value is int ? value == 1 : (value as bool?) ?? true;
