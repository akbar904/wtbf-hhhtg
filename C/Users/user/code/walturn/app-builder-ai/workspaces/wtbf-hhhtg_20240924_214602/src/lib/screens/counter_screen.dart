
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/counter_cubit.dart';
import '../widgets/counter_display.dart';

class CounterScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Counter Multiply by 10'),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						BlocBuilder<CounterCubit, CounterState>(
							builder: (context, state) {
								return CounterDisplay(value: state.value);
							},
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								context.read<CounterCubit>().increment();
							},
							child: Text('Multiply by 10'),
						),
					],
				),
			),
		);
	}
}
