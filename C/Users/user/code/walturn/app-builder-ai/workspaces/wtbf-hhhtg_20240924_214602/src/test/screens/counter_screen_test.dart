
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_multiply_by_10/screens/counter_screen.dart';

class MockCounterCubit extends Mock implements CounterCubit {}

void main() {
	group('CounterScreen', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		testWidgets('renders CounterScreen with initial state', (tester) async {
			when(() => counterCubit.state).thenReturn(CounterState(1));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: CounterScreen(),
					),
				),
			);

			expect(find.text('Counter: 1'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('tapping increment button calls increment', (tester) async {
			when(() => counterCubit.state).thenReturn(CounterState(1));
			when(() => counterCubit.increment()).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: CounterScreen(),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			verify(() => counterCubit.increment()).called(1);
		});

		testWidgets('displays updated counter value when state changes', (tester) async {
			whenListen(
				counterCubit,
				Stream.fromIterable([CounterState(1), CounterState(10)]),
				initialState: CounterState(1),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: CounterScreen(),
					),
				),
			);

			expect(find.text('Counter: 1'), findsOneWidget);
			expect(find.text('Counter: 10'), findsNothing);

			await tester.pump();

			expect(find.text('Counter: 10'), findsOneWidget);
		});
	});
}
