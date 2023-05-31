import 'package:logging/logging.dart';
import 'package:plantilla_ca/domain/entities/example.dart';
import 'package:plantilla_ca/domain/repositories/example_repository.dart';

class DataMockExampleRepository implements ExampleRepository {
  factory DataMockExampleRepository() => _instance;
  Logger _logger;

  static final DataMockExampleRepository _instance =
      DataMockExampleRepository._internal();

  DataMockExampleRepository._internal()
      : _logger = Logger('DataMockExampleRepository');

  @override
  Future<Example> getGreeting(String greeting) async {
    try {
      _logger.finest('DataMockExampleRepository successful.');
      return Example(greeting: greeting);
    } catch (e) {
      _logger.severe('DataMockExampleRepository unsuccessful.');
      rethrow;
    }
  }
}
