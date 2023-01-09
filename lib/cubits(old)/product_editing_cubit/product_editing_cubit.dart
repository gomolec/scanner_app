import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_editing_state.dart';

class ProductEditingCubit extends Cubit<ProductEditingState> {
  ProductEditingCubit() : super(ProductEditingInitial());

  @override
  Future<void> close() {
    return super.close();
  }
}
