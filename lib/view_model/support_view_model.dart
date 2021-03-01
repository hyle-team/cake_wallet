import 'package:cake_wallet/generated/i18n.dart';
import 'package:cake_wallet/routes.dart';
import 'package:cake_wallet/view_model/settings/link_list_item.dart';
import 'package:cake_wallet/view_model/settings/regular_list_item.dart';
import 'package:cake_wallet/view_model/settings/settings_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'support_view_model.g.dart';

class SupportViewModel = SupportViewModelBase with _$SupportViewModel;

abstract class SupportViewModelBase with Store {
  SupportViewModelBase() {
    items = [
      RegularListItem(
        title: S.current.faq,
        handler: (BuildContext context) =>
            Navigator.pushNamed(context, Routes.faq),
      ),
      LinkListItem(
          title: 'Email',
          linkTitle: 'support@cakewallet.com',
          link: 'mailto:support@cakewallet.com'),
      LinkListItem(
          title: 'Telegram',
          icon: 'assets/images/Telegram.png',
          linkTitle: '@cakewallet_bot',
          link: 'https:t.me/cakewallet_bot'),
      LinkListItem(
          title: 'Twitter',
          icon: 'assets/images/Twitter.png',
          linkTitle: '@cakewallet',
          link: 'https://twitter.com/cakewallet'),
      LinkListItem(
          title: 'ChangeNow',
          icon: 'assets/images/change_now.png',
          linkTitle: 'support@changenow.io',
          link: 'mailto:support@changenow.io')
    ];
  }
  List<SettingsListItem> items;
}