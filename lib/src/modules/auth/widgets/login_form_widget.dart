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


  void signIn() {
    if (_signInKey.currentState!.validate()) {
      print('Sign In');
    }
  }

  void signUp() {
    if (_signUpKey.currentState!.validate()) {
      print('Sign Up');
    }
  }

  void reset() {
    if (_resetKey.currentState!.validate()) {
      print('Reset');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                tabs: [
                  Form(
                    key:  _signInKey,
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
                              isVisible ? Icons.visibility : Icons.visibility_off,
                              size: 20,
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                    
                          CommonFilledButton(onPressed: signIn, label: 'Sign In'),
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
                            isVisible ? Icons.visibility : Icons.visibility_off,
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
      
                        CommonFilledButton(onPressed: signUp, label: 'Sign Up'),
                      ],
                    ),
                  )),
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
                        CommonFilledButton(onPressed: reset, label: 'Reset'),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
