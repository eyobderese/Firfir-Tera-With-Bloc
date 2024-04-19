import 'package:flutter/material.dart';
// import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
// import 'package:google_fonts/google_fonts.dart';

class Register_2 extends StatefulWidget {
  const Register_2({super.key});

  @override
  State<Register_2> createState() => _Register_2State();
}

class _Register_2State extends State<Register_2> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  void _submit() {
    String firstName = _firstName.text;
    String lastName = _lastName.text;
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/log_reg_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register_1');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                children: [
                  Text(
                    "Fill in Your Bio to get Started",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "The data will be displayed in your account profile ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      controller: _firstName,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "first_name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _lastName,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "last_name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        controller: _bio,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.message),
                            labelText: 'bio',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                              right: Radius.circular(50),
                            )))),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register_3');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        minimumSize:
                            MaterialStateProperty.all(const Size(130, 60)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Next",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}