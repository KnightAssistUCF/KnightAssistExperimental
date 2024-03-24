import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../global/widgets/scrollable_column.dart';

class EditOrganizationScreen extends HookConsumerWidget {
  const EditOrganizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final org = ref.watch(currentOrganizationProvider);

    // Controllers
    final nameController = useTextEditingController(text: org!.name);
    final descriptionController =
        useTextEditingController(text: org.description);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    floatingText: 'Name',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: descriptionController,
                    floatingText: 'Description',
                    multiline: true,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Confirm button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: CustomTextButton(
                width: double.infinity,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(organizationsProvider).editOrg(
                        orgId: org.organizationId!,
                        name: nameController.text,
                        description: descriptionController.text);
                  }
                },
                child: const Center(
                  child: Text(
                    'Confirm',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
