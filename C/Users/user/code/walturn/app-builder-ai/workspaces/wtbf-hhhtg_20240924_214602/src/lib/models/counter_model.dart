
class CounterModel {
	int value;

	CounterModel({required this.value});

	Map<String, dynamic> toJson() {
		return {'value': value};
	}

	static CounterModel fromJson(Map<String, dynamic> json) {
		return CounterModel(value: json['value']);
	}
}
