import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_event.dart';
import 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const AboutState()) {
    on<AboutEmailTapped>(_onEmailTapped);
  }

  void _onEmailTapped(AboutEmailTapped event, Emitter<AboutState> emit) {
    // TODO: open the mail client with url_launcher:
    //
    //   await launchUrl(
    //     Uri(scheme: 'mailto', path: AboutData.supportEmail),
    //   );
    //
    // Left as a no-op until the dependency is added.
  }
}