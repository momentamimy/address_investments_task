import 'package:address_investments_task/core/config/theme/context_theme.dart';
import 'package:address_investments_task/features/home/presentation/blocs/update_product_cubit/update_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../params/update_product_params.dart';

class UpdateProductSheet extends StatefulWidget {
  const UpdateProductSheet({super.key});

  @override
  State<UpdateProductSheet> createState() => _UpdateProductSheetState();
}

class _UpdateProductSheetState extends State<UpdateProductSheet> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
        text: context.read<UpdateProductCubit>().state.title);
    priceController = TextEditingController(
        text: context.read<UpdateProductCubit>().state.price.toString());
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Edit Product",
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Text(
                      "Title",
                      style: context.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      validator: (value) => value!.isEmpty ? "Enter title" : null,
                    ),
                    20.verticalSpace,
                    Text(
                      "Product description",
                      style: context.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      validator: (value) => value!.isEmpty ? "Enter title" : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          StatefulBuilder(builder: (context, setState) {
            return isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 50.h)),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      setState(() => isLoading = true);
                      await context.read<UpdateProductCubit>().updateProduct(
                            params: UpdateProductParams(
                                title: titleController.text,
                                price: int.tryParse(priceController.text),
                                productId:
                                    context.read<UpdateProductCubit>().state.id),
                          );
                      context.pop();
                    },
                    child: const Text("Update"),
                  );
          }),
        ],
      ),
    );
  }
}
