part of 'brand_bloc.dart';

class ApiState extends Equatable {
  final List<Map<String, String>> data;
  final List<Map<String, String>> data1;
  final List<Map<String, String>> data2;

  const ApiState({required this.data, required this.data1,required this.data2});
  

  @override
  List<Object?> get props => [data, data1,data2];

  @override
  String toString() {
    return 'ApiState(data: $data, data1: $data1, data2: $data2)';
  }
}

