import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceinsights_emr_provider/core/config/aws_config.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/screens/patient_list.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PublishSubject<bool> _obscurePassword$ = PublishSubject();

  final BehaviorSubject<bool> _loading$ = BehaviorSubject.seeded(false);
  final PublishSubject<String> _alert$ = PublishSubject();
  final PublishSubject<void> _stateDispose$ = PublishSubject();

  @override
  void initState() {
    super.initState();
    _alert$
        .takeUntil(_stateDispose$)
        .flatMap((_) => Observable.timer(null, const Duration(seconds: 4)))
        .listen((_) => _alert$.add(null));
    _emailController.addListener(_clearWhitespaces(_emailController));
    _passwordController.addListener(_clearWhitespaces(_passwordController));
  }

  @override
  void dispose() {
    _stateDispose$.add(null);
    _stateDispose$.close();
    _obscurePassword$.close();
    _alert$.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff048abf),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 340,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "EMR-Mobile App",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: _emailController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      labelStyle: const TextStyle(color: Color(0xff9bd0e5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 0.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff9bd0e5)),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff9bd0e5)),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<bool>(
                      stream: _obscurePassword$,
                      initialData: true,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _passwordController,
                          obscureText: snapshot.data,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.remove_red_eye,
                                size: 24.0,
                                color: Color(0xff9bd0e5),
                              ),
                              onTap: () {
                                _obscurePassword$.add(!snapshot.data);
                              },
                            ),
                            labelStyle:
                                const TextStyle(color: Color(0xff9bd0e5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(width: 0.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xff9bd0e5)),
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xff9bd0e5)),
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                  const SizedBox(
                    height: 36.0,
                  ),
                  SizedBox(
                    width: 140,
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      color: Colors.white,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff048abf),
                          fontSize: 18.0,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: _login,
                    ),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder<String>(
            stream: _alert$,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Container(
                  width: 0.0,
                  height: 0.0,
                );
              }
              return Positioned(
                top: 32.0,
                width: MediaQuery.of(context).size.width,
                child: _AlertWidget(
                  message: snapshot.data,
                ),
              );
            },
          ),
          StreamBuilder(
              stream: _loading$,
              initialData: true,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return Container(
                      color: const Color(0xff048abf),
                      alignment: AlignmentDirectional.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: const Color(0xff9bd0e5),
                      ));
                }

                return Container(
                  height: 0.0,
                  width: 0.0,
                );
              })
        ],
      ),
    );
  }

  void Function() _clearWhitespaces(final TextEditingController controller) {
    final RegExp regExp = RegExp(r'\s');

    return () {
      if (regExp.hasMatch(controller.text)) {
        final String text = controller.text.replaceAll(regExp, '');

        controller.value = controller.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      }
    };
  }

  _login() async {
    if (_emailController.text == '' || _passwordController.text == '') {
      return;
    }

    FocusScope.of(context).unfocus();
    _loading$.add(true);

    final CognitoUserPool userPool = CognitoUserPool(
      AwsConfig.poolId,
      AwsConfig.clientId,
    );

    final CognitoUser cognitoUser =
        CognitoUser(_emailController.text, userPool);

    final AuthenticationDetails authDetails = AuthenticationDetails(
        username: _emailController.text, password: _passwordController.text);

    CognitoUserSession session;

    String errorMsg;

    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserException catch (e) {
      errorMsg = e.message;
    } on CognitoClientException catch (e) {
      errorMsg = e.message;
    } on Exception catch (e) {
      errorMsg = 'Something went wrong :(';
      debugPrint('ERROR: $e');
    }

    if (errorMsg == null) {
      final TokenService tokenService = TokenService();
      tokenService.token = session.getIdToken().getJwtToken();
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PatientsScreen(),
      ));

      _loading$.add(false);
      _emailController.text = '';
      _passwordController.text = '';
    } else {
      _loading$.add(false);
      _alert$.add(errorMsg);
    }
  }
}

class _AlertWidget extends StatelessWidget {
  final String message;

  _AlertWidget({@required this.message}) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        height: 41.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.info_outline,
              size: 20.0,
              color: const Color(0xffcd2615),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              message,
              style: const TextStyle(
                  color: const Color(0xffcd2615), fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}
