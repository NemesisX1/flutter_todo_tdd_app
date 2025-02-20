import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TodoOperationBottomSheet extends StatelessWidget {
  TodoOperationBottomSheet({
    super.key,
    this.todo,
  });

  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _scrollController = ScrollController();
  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (todo != null) {
      _titleTextController.text = todo!.title;
      _descriptionController.text = todo!.body;
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(20).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo != null ? 'Modifier ${todo!.title}' : 'Nouvelle tâche',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(30),
          Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 15,
              children: [
                TextFormField(
                  controller: _titleTextController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Le titre ne peut être vide';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Titre',
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 7,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Le titre ne peut être vide';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.pop<Todo>(
                  Todo(
                    title: _titleTextController.text,
                    body: _descriptionController.text,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(
                size.width,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              todo == null ? 'Ajouter' : 'Modifier',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
