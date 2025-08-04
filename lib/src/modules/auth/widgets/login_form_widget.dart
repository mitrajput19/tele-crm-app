import '../../../app/app.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool isVisible = false;
  final _signInKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();
  final _resetKey = GlobalKey<FormState>();
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
  }

  void signIn() {
    if (_signInKey.currentState!.validate()) {
      authBloc.add(AuthLoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void signUp() {
    if (_signUpKey.currentState!.validate()) {
      authBloc.add(AuthSignUpEvent(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      ));
    }
  }

  void reset() {
    if (_resetKey.currentState!.validate()) {
      authBloc.add(AuthResetPasswordEvent(_emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthLoginLoadingState) {
          if(state.isLoading){
            context.showLoader();
          }else{
            context.hideLoader();
          }
        } else if (state is AuthSignUpLoadingState) {
          if(state.isLoading){
            context.showLoader();
          }else{
            context.hideLoader();
          }
        } else if (state is AuthResetPasswordLoadingState) {
          if(state.isLoading){
            context.showLoader();
          }else{
            context.hideLoader();
          }
        } else if (state is AuthLoginLoadedState) {
          // Navigate to main app or dashboard
          context.go('/dashboard'); // Adjust route as needed
        } else if (state is AuthSignUpLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully! Please check your email to verify.')),
          );
        } else if (state is AuthResetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: CommonCard(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                AppLogo(size: 80),
                const SizedBox(height: 24),
                Text(
                  'Home Revise Sales',
                  style: Theme.of(context).textTheme.tsBold20,
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your demos and track your performance',
                  style: Theme.of(context).textTheme.tsRegular16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 470,
                  child: CommonTabBar(
                    tabsTitle: ['Sign In', 'Sign Up', 'Reset'],
                    onTabChanged: (index) => _clearControllers(),
                    tabs: [
                      Form(
                        key: _signInKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CommonTextField(
                                controller: _emailController,
                                label: 'Email',
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                              ),
                              CommonTextField(
                                controller: _passwordController,
                                label: 'Password',
                                hintText: 'Enter your password',
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !isVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                suffixIcon: CommonIcon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ),
                              ),

                              CommonFilledButton(
                                onPressed: signIn,
                                label: 'Sign In',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        key: _signUpKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CommonTextField(
                                controller: _nameController,
                                label: 'Name',
                                hintText: 'Enter your name',
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                              ),
                              CommonTextField(
                                controller: _emailController,
                                label: 'Email',
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                              ),
                              CommonTextField(
                                controller: _passwordController,
                                label: 'Password',
                                hintText: 'Enter your password',
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !isVisible,
                                suffixIcon: CommonIcon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),

                              CommonFilledButton(
                                onPressed: signUp,
                                label: 'Sign Up',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        key: _resetKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CommonTextField(
                                controller: _emailController,
                                label: 'Email',
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                              ),
                              CommonFilledButton(
                                onPressed: reset,
                                label: 'Reset',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
