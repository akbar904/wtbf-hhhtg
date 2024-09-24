
import 'package:bloc/bloc.dart';

class CounterState {
	final int value;

	const CounterState(this.value);

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is CounterState && runtimeType == other.runtimeType && value == other.value;

	@override
	int get hashCode => value.hashCode;
}

class CounterCubit extends Cubit<CounterState> {
	CounterCubit() : super(const CounterState(0));

	void increment() {
		final newValue = state.value == 0 ? 10 : state.value * 10;
		emit(CounterState(newValue));
	}
}
