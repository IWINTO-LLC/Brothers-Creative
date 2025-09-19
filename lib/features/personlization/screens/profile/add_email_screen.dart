import 'package:brothers_creative/common/widgets/appbar/appbar.dart';
import 'package:brothers_creative/data/repositoies/authentication/authentication_repository.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmailScreen extends StatefulWidget {
  const AddEmailScreen({super.key});

  @override
  State<AddEmailScreen> createState() => _AddEmailScreenState();
}

class _AddEmailScreenState extends State<AddEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authRepository = Get.put(AuthenticationRepository());
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _addEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authRepository.sendEmailVerification();
      setState(() {
        _isLoading = false;
      });

      Get.snackbar(
        'نجح',
        'تم إرسال رمز التأكيد',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'خطأ',
        'حدث خطأ: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('إضافة بريد إلكتروني'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'يرجى إدخال البريد الإلكتروني';
                  }
                  return null;
                },
              ),
              const SizedBox(height: TSizes.spaceBtWsections),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                  onPressed: _isLoading ? null : _addEmail,
                  child:
                      _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('إرسال رمز التأكيد'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
