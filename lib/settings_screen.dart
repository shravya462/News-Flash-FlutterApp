import 'package:flutter/material.dart';
import 'package:flutter_project/components/no_network.dart';
import 'package:flutter_project/components/text_widget.dart';
import 'package:flutter_project/l10n/app_localization.dart';
import 'package:flutter_project/localization_provider.dart';
import 'package:flutter_project/themeProvider.dart';
import 'package:flutter_project/utils/network_util.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(
            body: NoNetwork(),
          )
        : Scaffold(
            appBar: AppBar(
              title: TextWidget(
                txtTitle:
                    AppLocalizations.of(context)?.translate("settingsTitle") ??
                        "",
                txtFontStyle: FontWeight.w400,
                txtFontSize: 23,
              ),
              elevation: 50.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    title: TextWidget(
                      txtTitle: themeProvider.isDarkMode
                          ? AppLocalizations.of(context)
                                  ?.translate("switchToLightMode") ??
                              ""
                          : AppLocalizations.of(context)
                                  ?.translate("switchToDarkMode") ??
                              "",
                      txtFontStyle: FontWeight.w400,
                      txtFontSize: 17,
                    ),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ),
                  ListTile(
                    title: TextWidget(
                      txtTitle:
                          AppLocalizations.of(context)?.translate("language") ??
                              "",
                      txtFontStyle: FontWeight.w400,
                      txtFontSize: 17,
                    ),
                    trailing: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Locale>(
                          value: Localizations.localeOf(context),
                          items: [
                            DropdownMenuItem(
                              value: const Locale('en', ''),
                              child: TextWidget(
                                txtTitle: AppLocalizations.of(context)
                                        ?.translate("english") ??
                                    "",
                                txtFontStyle: FontWeight.w400,
                                txtFontSize: 17,
                              ),
                            ),
                            DropdownMenuItem(
                              value: const Locale('hi', ''),
                              child: TextWidget(
                                txtTitle: AppLocalizations.of(context)
                                        ?.translate("hindi") ??
                                    "",
                                txtFontStyle: FontWeight.w400,
                                txtFontSize: 17,
                              ),
                            ),
                          ],
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null) {
                              localizationProvider.setLocale(newLocale);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
