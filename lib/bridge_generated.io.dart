// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.81.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'bridge_generated.dart';
export 'bridge_generated.dart';
import 'dart:ffi' as ffi;

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_DataStruct> api2wire_box_autoadd_data_struct(
      DataStruct raw) {
    final ptr = inner.new_box_autoadd_data_struct_0();
    _api_fill_to_wire_data_struct(raw, ptr.ref);
    return ptr;
  }

  @protected
  int api2wire_i64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_list___record__expr_String>
      api2wire_list___record__expr_String(List<(Expr, String)> raw) {
    final ans = inner.new_list___record__expr_String_0(raw.length);
    for (var i = 0; i < raw.length; ++i) {
      _api_fill_to_wire___record__expr_String(raw[i], ans.ref.ptr[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_list___record__expr_type_String>
      api2wire_list___record__expr_type_String(List<(ExprType, String)> raw) {
    final ans = inner.new_list___record__expr_type_String_0(raw.length);
    for (var i = 0; i < raw.length; ++i) {
      _api_fill_to_wire___record__expr_type_String(raw[i], ans.ref.ptr[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire

  void _api_fill_to_wire___record__expr_String(
      (Expr, String) apiObj, wire___record__expr_String wireObj) {
    _api_fill_to_wire_expr(apiObj.$1, wireObj.field0);
    wireObj.field1 = api2wire_String(apiObj.$2);
  }

  void _api_fill_to_wire___record__expr_type_String(
      (ExprType, String) apiObj, wire___record__expr_type_String wireObj) {
    wireObj.field0 = api2wire_expr_type(apiObj.$1);
    wireObj.field1 = api2wire_String(apiObj.$2);
  }

  void _api_fill_to_wire_box_autoadd_data_struct(
      DataStruct apiObj, ffi.Pointer<wire_DataStruct> wireObj) {
    _api_fill_to_wire_data_struct(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_data_struct(
      DataStruct apiObj, wire_DataStruct wireObj) {
    _api_fill_to_wire_expr(apiObj.currentExpr, wireObj.current_expr);
    wireObj.history_expr =
        api2wire_list___record__expr_String(apiObj.historyExpr);
  }

  void _api_fill_to_wire_expr(Expr apiObj, wire_Expr wireObj) {
    wireObj.expr_list =
        api2wire_list___record__expr_type_String(apiObj.exprList);
    wireObj.l_bracket_count = api2wire_i64(apiObj.lBracketCount);
    wireObj.r_bracket_count = api2wire_i64(apiObj.rBracketCount);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_store_history(
    int port_,
    ffi.Pointer<wire_uint_8_list> path,
    ffi.Pointer<wire_DataStruct> history,
  ) {
    return _wire_store_history(
      port_,
      path,
      history,
    );
  }

  late final _wire_store_historyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_DataStruct>)>>('wire_store_history');
  late final _wire_store_history = _wire_store_historyPtr.asFunction<
      void Function(
          int, ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_DataStruct>)>();

  void wire_get_histroy(
    int port_,
    ffi.Pointer<wire_uint_8_list> path,
  ) {
    return _wire_get_histroy(
      port_,
      path,
    );
  }

  late final _wire_get_histroyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_get_histroy');
  late final _wire_get_histroy = _wire_get_histroyPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  WireSyncReturn wire_dart_calculate(
    ffi.Pointer<wire_uint_8_list> input,
  ) {
    return _wire_dart_calculate(
      input,
    );
  }

  late final _wire_dart_calculatePtr = _lookup<
      ffi.NativeFunction<
          WireSyncReturn Function(
              ffi.Pointer<wire_uint_8_list>)>>('wire_dart_calculate');
  late final _wire_dart_calculate = _wire_dart_calculatePtr
      .asFunction<WireSyncReturn Function(ffi.Pointer<wire_uint_8_list>)>();

  ffi.Pointer<wire_DataStruct> new_box_autoadd_data_struct_0() {
    return _new_box_autoadd_data_struct_0();
  }

  late final _new_box_autoadd_data_struct_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_DataStruct> Function()>>(
          'new_box_autoadd_data_struct_0');
  late final _new_box_autoadd_data_struct_0 = _new_box_autoadd_data_struct_0Ptr
      .asFunction<ffi.Pointer<wire_DataStruct> Function()>();

  ffi.Pointer<wire_list___record__expr_String> new_list___record__expr_String_0(
    int len,
  ) {
    return _new_list___record__expr_String_0(
      len,
    );
  }

  late final _new_list___record__expr_String_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_list___record__expr_String> Function(
              ffi.Int32)>>('new_list___record__expr_String_0');
  late final _new_list___record__expr_String_0 =
      _new_list___record__expr_String_0Ptr.asFunction<
          ffi.Pointer<wire_list___record__expr_String> Function(int)>();

  ffi.Pointer<wire_list___record__expr_type_String>
      new_list___record__expr_type_String_0(
    int len,
  ) {
    return _new_list___record__expr_type_String_0(
      len,
    );
  }

  late final _new_list___record__expr_type_String_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_list___record__expr_type_String> Function(
              ffi.Int32)>>('new_list___record__expr_type_String_0');
  late final _new_list___record__expr_type_String_0 =
      _new_list___record__expr_type_String_0Ptr.asFunction<
          ffi.Pointer<wire_list___record__expr_type_String> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
          ffi
          .NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>(
      'new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire___record__expr_type_String extends ffi.Struct {
  @ffi.Int32()
  external int field0;

  external ffi.Pointer<wire_uint_8_list> field1;
}

final class wire_list___record__expr_type_String extends ffi.Struct {
  external ffi.Pointer<wire___record__expr_type_String> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_Expr extends ffi.Struct {
  external ffi.Pointer<wire_list___record__expr_type_String> expr_list;

  @ffi.Int64()
  external int l_bracket_count;

  @ffi.Int64()
  external int r_bracket_count;
}

final class wire___record__expr_String extends ffi.Struct {
  external wire_Expr field0;

  external ffi.Pointer<wire_uint_8_list> field1;
}

final class wire_list___record__expr_String extends ffi.Struct {
  external ffi.Pointer<wire___record__expr_String> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_DataStruct extends ffi.Struct {
  external wire_Expr current_expr;

  external ffi.Pointer<wire_list___record__expr_String> history_expr;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
