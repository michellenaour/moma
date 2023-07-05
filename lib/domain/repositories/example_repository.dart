import 'package:MOMO/domain/entities/example.dart';

abstract class ExampleRepository {
  Future<Example> getGreeting(String greeting);
}
