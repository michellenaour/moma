import 'package:plantilla_ca/domain/entities/example.dart';

abstract class ExampleRepository {
  Future<Example> getGreeting(String greeting);
}
