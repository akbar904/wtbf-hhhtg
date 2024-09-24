
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counter_multiply_by_10/cubits/counter_cubit.dart';
import 'package:counter_multiply_by_10/main.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders CounterScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(CounterScreen), findsOneWidget);
		});
	});

	group('CounterCubit', () {
		blocTest<CounterCubit, int>(
			'emits [0, 10] when increment is called',
			build: () => CounterCubit(),
			act: (cubit) => cubit.increment(),
			expect: () => [0, 10],
		);
	});

	group('CounterScreen', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		testWidgets('displays initial counter value', (WidgetTester tester) async {
			when(() => counterCubit.state).thenReturn(0);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: CounterScreen(),
					),
				),
			);

			expect(find.text('0'), findsOneWidget);
		});

		testWidgets('calls increment when button is pressed', (WidgetTester tester) async {
			when(() => counterCubit.state).thenReturn(0);
			when(() => counterCubit.increment()).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: CounterScreen(),
					),
				),
			);

			await tester.tap(find.byType(FloatingActionButton));
			verify(() => counterCubit.increment()).called(1);
		});
	});
}
