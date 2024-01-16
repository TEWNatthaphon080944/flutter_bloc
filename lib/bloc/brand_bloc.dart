import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final Repository _repository = Repository();

  ApiBloc() : super(const ApiState(data: [], data1: [],data2: [])) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(FetchDataEvent event, Emitter<ApiState> emit) async {
    try {
      final data = await _repository.fetchData();
      print('API Data: $data');
      
      // ให้ data1 เป็น List ว่าง เนื่องจาก ApiBloc ไม่ได้ใช้ data1
      emit(ApiState(data: data, data1: [],data2: []));
    } catch (error) {
      emit(const ApiState(data: [], data1: [],data2: []));
    }
  }
}

class ApiBlocApple extends Bloc<ApiEvent, ApiState> {
  final RepositoryApple _repository = RepositoryApple();

  ApiBlocApple() : super(const ApiState(data: [], data1: [],data2: [])) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(FetchDataEvent event, Emitter<ApiState> emit) async {
    try {
      final data1 = await _repository.fetchData();
      print('API DataApple: $data1');
      
      // ให้ data เป็น List ว่าง เนื่องจาก ApiBlocApple ไม่ได้ใช้ data
      emit(ApiState(data: [],data2: [], data1: data1));
    } catch (error) {
      emit(const ApiState(data: [],data2: [], data1: []));
    }
  }
}
class ApiBlocSamsung extends Bloc<ApiEvent, ApiState> {
  final RepositorySamsung _repository = RepositorySamsung();

  ApiBlocSamsung() : super(const ApiState(data: [],data2: [], data1: [])) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(FetchDataEvent event, Emitter<ApiState> emit) async {
    try {
      final data2 = await _repository.fetchData();
      print('API DataApple: $data2');
      
      emit(ApiState(data: [],data1: [], data2: data2));
    } catch (error) {
      emit(const ApiState(data: [],data1: [], data2: []));
    }
  }
}