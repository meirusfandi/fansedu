import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/features/about/bloc/about_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  
  @override
  void initState() {
    sl<AboutBloc>().add(GetReferenceEvent("about-fansedu"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        return Loadable(
          loading: state.isLoading,
          backgroundColor: Colors.white,
          appBar: BackAppBar(
            context, "About",
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: LeftAlignedColumn(
                children: [
                  HtmlWidget(
                    '''
                    ${state.referencesEntity?.data.firstOrNull?.content_id}
                    '''
                  )
                ],
              ).horizontalPadded(24),
            )
          ),
        );
      }
    );
  }
}
