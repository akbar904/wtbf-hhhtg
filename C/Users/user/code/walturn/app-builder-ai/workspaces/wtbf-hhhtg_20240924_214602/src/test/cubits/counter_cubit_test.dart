
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counter_multiply_by_10/cubits/counter_cubit.dart';

void main() {
	group('CounterCubit', () {

		blocTest<CounterCubit, CounterState>(
			'emits [CounterState(0)] when initialized',
			build: () => CounterCubit(),
			expect: () => const <CounterState>[],
		);

		blocTest<CounterCubit, CounterState>(
			'emits [CounterState(0), CounterState(10)] when increment is called once',
			build: () => CounterCubit(),
			act: (cubit) => cubit.increment(),
			expect: () => [
				const CounterState(10),
			],
		);

		blocTest<CounterCubit, CounterState>(
			'emits [CounterState(0), CounterState(10), CounterState(100)] when increment is called twice',
			build: () => CounterCubit(),
			act: (cubit) {
				cubit.increment();
				cubit.increment();
			},
			expect: () => [
				const CounterState(10),
				const CounterState(100),
			],
		);

		blocTest<CounterCubit, CounterState>(
			'initial state is CounterState(0)',
			build: () => CounterCubit(),
			verify: (cubit) => expect(cubit.state, const CounterState(0)),
		);
	});
}
