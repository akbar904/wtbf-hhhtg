
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:com.example.counter_multiply_by_10/widgets/counter_display.dart';
import 'package:com.example.counter_multiply_by_10/cubits/counter_cubit.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
	group('CounterDisplay Widget Tests', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		testWidgets('displays the current counter value', (WidgetTester tester) async {
			when(() => counterCubit.state).thenReturn(10);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: const CounterDisplay(),
					),
				),
			);

			expect(find.text('10'), findsOneWidget);
		});

		testWidgets('displays updated counter value when state changes', (WidgetTester tester) async {
			whenListen(counterCubit, Stream.fromIterable([0, 10, 20]), initialState: 0);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: const CounterDisplay(),
					),
				),
			);

			// Initial state
			expect(find.text('0'), findsOneWidget);

			// State changes to 10
			await tester.pump();
			expect(find.text('10'), findsOneWidget);

			// State changes to 20
			await tester.pump();
			expect(find.text('20'), findsOneWidget);
		});
	});
}
