
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_multiply_by_10/models/counter_model.dart';

void main() {
	group('CounterModel', () {
		test('should initialize with a value of 0', () {
			final counter = CounterModel(value: 0);
			expect(counter.value, 0);
		});

		test('should correctly initialize with a given value', () {
			final counter = CounterModel(value: 5);
			expect(counter.value, 5);
		});

		test('should correctly serialize to JSON', () {
			final counter = CounterModel(value: 10);
			final json = counter.toJson();
			expect(json, {'value': 10});
		});

		test('should correctly deserialize from JSON', () {
			final json = {'value': 20};
			final counter = CounterModel.fromJson(json);
			expect(counter.value, 20);
		});
	});
}
