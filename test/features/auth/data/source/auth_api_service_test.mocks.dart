// Mocks generated by Mockito 5.4.4 from annotations
// in challange_beclever/test/features/auth/data/source/auth_api_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:challange_beclever/core/network/dio_client_fake.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DioClientFake].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioClientFake extends _i1.Mock implements _i2.DioClientFake {
  MockDioClientFake() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.Response> get(
    String? url, {
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#queryParameters: queryParameters},
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [url],
            {#queryParameters: queryParameters},
          ),
        )),
      ) as _i3.Future<_i2.Response>);

  @override
  _i3.Future<_i2.Response> post(
    String? url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #data: data,
            #queryParameters: queryParameters,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #data: data,
              #queryParameters: queryParameters,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);

  @override
  _i3.Future<_i2.Response> patch(
    String? url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #data: data,
            #queryParameters: queryParameters,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #data: data,
              #queryParameters: queryParameters,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);
}
