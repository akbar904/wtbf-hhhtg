
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.counter_multiply_by_10/cubits/counter_cubit.dart';

class CounterDisplay extends StatelessWidget {
	const CounterDisplay({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final counterValue = context.watch<CounterCubit>().state;
		return Center(
			child: Text(
				'$counterValue',
				style: TextStyle(fontSize: 24),
			),
		);
	}
}
