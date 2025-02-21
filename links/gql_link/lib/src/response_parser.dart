import "package:gql_exec/gql_exec.dart";

/// JSON [Response] parser
class ResponseParser {
  const ResponseParser();

  /// Parses the response body
  ///
  /// Extend this to add non-standard behavior
  Response parseResponse(Map<String, dynamic> body) => Response(
        errors: (body["errors"] as List?)
            ?.map(
              (dynamic error) => parseError(error as Map<String, dynamic>),
            )
            .toList(),
        data: body["data"] as Map<String, dynamic>?,
        response: body,
        context: Context().withEntry(
          ResponseExtensions(
            body["extensions"],
          ),
        ),
      );

  /// Parses a response error
  ///
  /// Extend this to add non-standard behavior
  GraphQLError parseError(Map<String, dynamic> error) => GraphQLError(
        message: error["message"] as String,
        path: error["path"] as List?,
        locations: (error["locations"] as List?)
            ?.map(
              (dynamic location) =>
                  parseLocation(location as Map<String, dynamic>),
            )
            .toList(),
        extensions: error["extensions"] as Map<String, dynamic>?,
        raw: error,
      );

  /// Parses a response error location
  ///
  /// Extend this to add non-standard behavior
  ErrorLocation parseLocation(Map<String, dynamic> location) => ErrorLocation(
        line: location["line"] as int,
        column: location["column"] as int,
      );
}
