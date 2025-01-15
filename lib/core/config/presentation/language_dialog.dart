import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/config/bloc/config_bloc.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/core/config/model/language_response.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDialog extends StatefulWidget {
  final String lang;
  final Function(DataLanguage?) callback;
  const LanguageDialog({
    super.key,
    required this.lang,
    required this.callback,
  });

  @override
  State<LanguageDialog> createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  DataLanguage? _onDataCheck;
  List<DataLanguage> data = [
    const DataLanguage(code: 'id', name: 'Bahasa Indonesia', sort: 1),
    const DataLanguage(code: 'en', name: 'English', sort: 2),
  ];

  Future<void> setSelectedLang() async {
    try {
      _onDataCheck ??=
          data.singleWhere((element) => element.code == widget.lang);
    } catch (e) {
      _onDataCheck = DataLanguage(code: LangConfig.instance.langValue);
    }
  }

  @override
  void initState() {
    setSelectedLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigBloc, ConfigState>(listener: (context, state) {
      if (!state.isLoading && state.onUpdateLang) {
        context.router.maybePop().then((_) => widget.callback(_onDataCheck));
      } else if (!state.isLoading && !state.onUpdateLang) {
        showError(context, S.of(context).general_error);
      }
    }, builder: (context, state) {
      return BottomDrawer(
        child: LeftAlignedColumn(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext ctx, int idx) => InkWell(
                      onTap: () => setState(() => _onDataCheck = data[idx]),
                      child: LeftAlignedColumn(
                        children: [
                          LeftAlignedRow(
                            children: [
                              Expanded(
                                child: TextWidget.jakartaSansRegular(data[idx].name ?? '',
                                    color: Colors.black, size: 14),
                              ),
                              (data[idx].code ?? '') ==
                                      (_onDataCheck?.code ?? '')
                                  ? const Icon(Icons.check)
                                  : const SizedBox()
                            ],
                          ).verticalPadded(10).horizontalPadded(),
                          const Divider()
                        ],
                      ),
                    )),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  sl<ConfigBloc>().add(ChangeLanguageEvent(
                      newLocal: _onDataCheck?.code ?? 'id'));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: ColorWidget.primaryColor),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : TextWidget.jakartaSansSemiBold(
                            S.of(context).general_save,
                            color: Colors.white,
                            size: 16,
                            textAlign: TextAlign.center,
                          )
                          .padded(),
                ),
              ).bottomPadded(8),
            ).topPadded(),
          ],
        ),
      );
    });
  }
}
