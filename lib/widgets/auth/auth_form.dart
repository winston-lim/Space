import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(
    String email,
    String password,
    String userName,
    bool isUserLoggedIn,
    BuildContext ctx,
  ) submitFn;
  const AuthForm(
    this.submitFn,
  );
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _homeController = ScrollController();
  bool _logInMode = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid ?? false) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _logInMode,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            controller: _homeController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Space',
                    style: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          key: const ValueKey('email'),
                          autocorrect: false,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                          ),
                          onSaved: (value) {
                            _userEmail = value ?? '';
                          },
                        ),
                        if (!_logInMode)
                          TextFormField(
                            key: const ValueKey('username'),
                            textCapitalization: TextCapitalization.words,
                            enableSuggestions: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            onSaved: (value) {
                              _userName = value ?? '';
                            },
                          ),
                        TextFormField(
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value) {
                            _userPassword = value ?? '';
                          },
                        ),
                        const SizedBox(height: 12),
                        if (_isLoading) const CircularProgressIndicator(),
                        if (!_isLoading)
                          RaisedButton(
                            onPressed: () {
                              _trySubmit();
                              _homeController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: Text(_logInMode ? 'Login' : 'Signup'),
                          ),
                        if (!_isLoading)
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              setState(() {
                                _logInMode = !_logInMode;
                              });
                              _homeController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: Text(_logInMode
                                ? 'Create new account'
                                : 'I already have an account'),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
