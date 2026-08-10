import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/bottom_nav.dart';

class MainShellState extends Equatable {
  const MainShellState({this.selectedIndex = 0});

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
}

class MainShellCubit extends Cubit<MainShellState> {
  MainShellCubit() : super(const MainShellState());

  /// Switch tab programmatically from any child screen:
  /// `context.read<MainShellCubit>().switchTab(1);`
  void switchTab(int index) {
    if (index < 0 || index >= KolekBottomNav.items.length) return;
    if (state.selectedIndex == index) return;
    emit(MainShellState(selectedIndex: index));
  }

  void selectTab(int index) => switchTab(index);
}
