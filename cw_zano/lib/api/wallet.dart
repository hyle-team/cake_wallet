import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:cw_zano/api/structs/ut8_box.dart';
import 'package:cw_zano/api/convert_utf8_to_string.dart';
import 'package:cw_zano/api/signatures.dart';
import 'package:cw_zano/api/types.dart';
import 'package:cw_zano/api/zano_api.dart';
import 'package:cw_zano/api/calls.dart' as calls;
import 'package:cw_zano/api/exceptions/setup_wallet_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

int _boolToInt(bool value) => value ? 1 : 0;

final getFileNameNative = zanoApi
    .lookup<NativeFunction<get_filename>>('get_filename')
    .asFunction<GetFilename>();

/*final getSeedNative =
    zanoApi.lookup<NativeFunction<get_seed>>('seed').asFunction<GetSeed>();*/

final getAddressNative = zanoApi
    .lookup<NativeFunction<get_address>>('get_address')
    .asFunction<GetAddress>();

final getFullBalanceNative = zanoApi
    .lookup<NativeFunction<get_full_balanace>>('get_full_balance')
    .asFunction<GetFullBalance>();

final getUnlockedBalanceNative = zanoApi
    .lookup<NativeFunction<get_unlocked_balanace>>('get_unlocked_balance')
    .asFunction<GetUnlockedBalance>();

/**final getCurrentHeightNative = zanoApi
    .lookup<NativeFunction<get_current_height>>('get_current_height')
    .asFunction<GetCurrentHeight>();*/

final getNodeHeightNative = zanoApi
    .lookup<NativeFunction<get_node_height>>('get_node_height')
    .asFunction<GetNodeHeight>();

final isConnectedNative = zanoApi
    .lookup<NativeFunction<is_connected>>('is_connected')
    .asFunction<IsConnected>();

final setupNodeNative = zanoApi
    .lookup<NativeFunction<setup_node>>('setup_node')
    .asFunction<SetupNode>();

final startRefreshNative = zanoApi
    .lookup<NativeFunction<start_refresh>>('start_refresh')
    .asFunction<StartRefresh>();

final connecToNodeNative = zanoApi
    .lookup<NativeFunction<connect_to_node>>('connect_to_node')
    .asFunction<ConnectToNode>();

final setRefreshFromBlockHeightNative = zanoApi
    .lookup<NativeFunction<set_refresh_from_block_height>>(
        'set_refresh_from_block_height')
    .asFunction<SetRefreshFromBlockHeight>();

final setRecoveringFromSeedNative = zanoApi
    .lookup<NativeFunction<set_recovering_from_seed>>(
        'set_recovering_from_seed')
    .asFunction<SetRecoveringFromSeed>();

final storeNative =
    zanoApi.lookup<NativeFunction<store_c>>('store').asFunction<Store>();

final setPasswordNative = zanoApi
    .lookup<NativeFunction<set_password>>('set_password')
    .asFunction<SetPassword>();

/**final setListenerNative = zanoApi
    .lookup<NativeFunction<set_listener>>('set_listener')
    .asFunction<SetListener>();*/

final getSyncingHeightNative = zanoApi
    .lookup<NativeFunction<get_syncing_height>>('get_syncing_height')
    .asFunction<GetSyncingHeight>();

final isNeededToRefreshNative = zanoApi
    .lookup<NativeFunction<is_needed_to_refresh>>('is_needed_to_refresh')
    .asFunction<IsNeededToRefresh>();

final isNewTransactionExistNative = zanoApi
    .lookup<NativeFunction<is_new_transaction_exist>>(
        'is_new_transaction_exist')
    .asFunction<IsNewTransactionExist>();

final getSecretViewKeyNative = zanoApi
    .lookup<NativeFunction<secret_view_key>>('secret_view_key')
    .asFunction<SecretViewKey>();

final getPublicViewKeyNative = zanoApi
    .lookup<NativeFunction<public_view_key>>('public_view_key')
    .asFunction<PublicViewKey>();

final getSecretSpendKeyNative = zanoApi
    .lookup<NativeFunction<secret_spend_key>>('secret_spend_key')
    .asFunction<SecretSpendKey>();

final getPublicSpendKeyNative = zanoApi
    .lookup<NativeFunction<secret_view_key>>('public_spend_key')
    .asFunction<PublicSpendKey>();

final closeCurrentWalletNative = zanoApi
    .lookup<NativeFunction<close_current_wallet>>('close_current_wallet')
    .asFunction<CloseCurrentWallet>();

final onStartupNative = zanoApi
    .lookup<NativeFunction<on_startup>>('on_startup')
    .asFunction<OnStartup>();

final rescanBlockchainAsyncNative = zanoApi
    .lookup<NativeFunction<rescan_blockchain>>('rescan_blockchain')
    .asFunction<RescanBlockchainAsync>();

final setTrustedDaemonNative = zanoApi
    .lookup<NativeFunction<set_trusted_daemon>>('set_trusted_daemon')
    .asFunction<SetTrustedDaemon>();

final trustedDaemonNative = zanoApi
    .lookup<NativeFunction<trusted_daemon>>('trusted_daemon')
    .asFunction<TrustedDaemon>();

int getSyncingHeight() => getSyncingHeightNative();

bool isNeededToRefresh() => isNeededToRefreshNative() != 0;

bool isNewTransactionExist() => isNewTransactionExistNative() != 0;

String getFilename() => convertUTF8ToString(pointer: getFileNameNative());

/**String getSeed() => convertUTF8ToString(pointer: getSeedNative());*/

String getAddress({int accountIndex = 0, int addressIndex = 0}) =>
    convertUTF8ToString(pointer: getAddressNative(accountIndex, addressIndex));

int getFullBalance({int accountIndex = 0}) =>
    getFullBalanceNative(accountIndex);

int getUnlockedBalance({int accountIndex = 0}) =>
    getUnlockedBalanceNative(accountIndex);

int getCurrentHeight(int hWallet) {
  calls.getWalletStatus(hWallet);
  return -1;
  //return getCurrentHeightNative();
}

int getNodeHeightSync() => getNodeHeightNative();

bool isConnectedSync() => isConnectedNative() != 0;

bool setupNodeSync(
    {required String address,
    String? login,
    String? password,
    bool useSSL = false,
    bool isLightWallet = false,
    /*String? socksProxyAddress*/}) {
  final addressPointer = address.toNativeUtf8();
  Pointer<Utf8>? loginPointer;
  Pointer<Utf8>? socksProxyAddressPointer;
  Pointer<Utf8>? passwordPointer;

  if (login != null) {
    loginPointer = login.toNativeUtf8();
  }

  if (password != null) {
    passwordPointer = password.toNativeUtf8();
  }

  /*if (socksProxyAddress != null) {
    socksProxyAddressPointer = socksProxyAddress.toNativeUtf8();
  }*/

  final errorMessagePointer = ''.toNativeUtf8();
  debugPrint("setup_node address $address login $login password $password useSSL $useSSL isLightWallet $isLightWallet");
  // TODO: here can be ZERO! upd: no
  final isSetupNode = setupNodeNative(
          addressPointer,
          loginPointer,
          passwordPointer,
          _boolToInt(useSSL),
          _boolToInt(isLightWallet),
          /*socksProxyAddressPointer,*/
          errorMessagePointer) !=
      0;
  debugPrint("setup_node result $isSetupNode");

  calloc.free(addressPointer);

  if (loginPointer != null) {
    calloc.free(loginPointer);
  }

  if (passwordPointer != null) {
    calloc.free(passwordPointer);
  }

  // TODO: fix it
  /**if (!isSetupNode) {
    throw SetupWalletException(
        message: convertUTF8ToString(pointer: errorMessagePointer));
  }*/

  return isSetupNode;
}

void startRefreshSync() => startRefreshNative();

Future<bool> connectToNode() async => connecToNodeNative() != 0;

void setRefreshFromBlockHeight({required int height}) =>
    setRefreshFromBlockHeightNative(height);

void setRecoveringFromSeed({required bool isRecovery}) =>
    setRecoveringFromSeedNative(_boolToInt(isRecovery));

void storeSync(int hWallet) {
  calls.store(hWallet);
  // TODO: fixit
  /*final pathPointer = ''.toNativeUtf8();
  storeNative(pathPointer);
  calloc.free(pathPointer);*/
}

void setPasswordSync(String password) {
  final passwordPointer = password.toNativeUtf8();
  final errorMessagePointer = calloc<Utf8Box>();
  final changed = setPasswordNative(passwordPointer, errorMessagePointer) != 0;
  calloc.free(passwordPointer);

  if (!changed) {
    final message = errorMessagePointer.ref.getValue();
    calloc.free(errorMessagePointer);
    throw Exception(message);
  }

  calloc.free(errorMessagePointer);
}

void closeCurrentWallet() => closeCurrentWalletNative();

String getSecretViewKey() =>
    convertUTF8ToString(pointer: getSecretViewKeyNative());

String getPublicViewKey() =>
    convertUTF8ToString(pointer: getPublicViewKeyNative());

String getSecretSpendKey() =>
    convertUTF8ToString(pointer: getSecretSpendKeyNative());

String getPublicSpendKey() =>
    convertUTF8ToString(pointer: getPublicSpendKeyNative());

class SyncListener {
  SyncListener(this.onNewBlock, this.onNewTransaction)
      : _cachedBlockchainHeight = 0,
        _lastKnownBlockHeight = 0,
        _initialSyncHeight = 0;

  void Function(int, int, double) onNewBlock;
  void Function() onNewTransaction;

  Timer? _updateSyncInfoTimer;
  int _cachedBlockchainHeight;
  int _lastKnownBlockHeight;
  int _initialSyncHeight;

  Future<int> getNodeHeightOrUpdate(int baseHeight) async {
    if (_cachedBlockchainHeight < baseHeight || _cachedBlockchainHeight == 0) {
      _cachedBlockchainHeight = await getNodeHeight();
    }

    return _cachedBlockchainHeight;
  }

  void start() {
    _cachedBlockchainHeight = 0;
    _lastKnownBlockHeight = 0;
    _initialSyncHeight = 0;
    _updateSyncInfoTimer ??=
        Timer.periodic(Duration(milliseconds: 1200), (_) async {
      if (isNewTransactionExist()) {
        onNewTransaction?.call();
      }

      var syncHeight = getSyncingHeight();

      if (syncHeight <= 0) {
        // TODO: fix it
        syncHeight = getCurrentHeight(-1);
      }

      if (_initialSyncHeight <= 0) {
        _initialSyncHeight = syncHeight;
      }

      final bchHeight = await getNodeHeightOrUpdate(syncHeight);

      if (_lastKnownBlockHeight == syncHeight || syncHeight == null) {
        return;
      }

      _lastKnownBlockHeight = syncHeight;
      final track = bchHeight - _initialSyncHeight;
      final diff = track - (bchHeight - syncHeight);
      final ptc = diff <= 0 ? 0.0 : diff / track;
      final left = bchHeight - syncHeight;

      if (syncHeight < 0 || left < 0) {
        return;
      }

      // 1. Actual new height; 2. Blocks left to finish; 3. Progress in percents;
      onNewBlock?.call(syncHeight, left, ptc);
    });
  }

  void stop() => _updateSyncInfoTimer?.cancel();
}

SyncListener setListeners(void Function(int, int, double) onNewBlock,
    void Function() onNewTransaction) {
  final listener = SyncListener(onNewBlock, onNewTransaction);
  /**setListenerNative();*/
  return listener;
}

void onStartup() => onStartupNative();

void _storeSync(int hWallet) => storeSync(hWallet);

bool _setupNodeSync(Map args) {
  final address = args['address'] as String;
  final login = (args['login'] ?? '') as String;
  final password = (args['password'] ?? '') as String;
  final useSSL = args['useSSL'] as bool;
  final isLightWallet = args['isLightWallet'] as bool;
  /*final socksProxyAddress = (args['socksProxyAddress'] ?? '') as String;*/

  return setupNodeSync(
      address: address,
      login: login,
      password: password,
      useSSL: useSSL,
      isLightWallet: isLightWallet,
      /*socksProxyAddress: socksProxyAddress*/);
}

bool _isConnected(Object _) => isConnectedSync();

int _getNodeHeight(Object _) => getNodeHeightSync();

void startRefresh() => startRefreshSync();

Future<bool> setupNode(
        {required String address,
        String? login,
        String? password,
        bool useSSL = false,
        /*String? socksProxyAddress,*/
        bool isLightWallet = false}) =>
    compute<Map<String, Object?>, bool>(_setupNodeSync, {
      'address': address,
      'login': login,
      'password': password,
      'useSSL': useSSL,
      'isLightWallet': isLightWallet,
      //'socksProxyAddress': socksProxyAddress
    });

Future<void> store(int hWallet) => compute<int, void>(_storeSync, 0);

Future<bool> isConnected() => compute(_isConnected, 0);

Future<int> getNodeHeight() => compute(_getNodeHeight, 0);

void rescanBlockchainAsync() => rescanBlockchainAsyncNative();

Future setTrustedDaemon(bool trusted) async =>
    setTrustedDaemonNative(_boolToInt(trusted));

Future<bool> trustedDaemon() async => trustedDaemonNative() != 0;
