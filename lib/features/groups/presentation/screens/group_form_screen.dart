import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_provider.dart';

const _colorOptions = [
  '#4CAF50',
  '#2196F3',
  '#FF9800',
  '#9C27B0',
  '#F44336',
  '#009688',
];

class GroupFormScreen extends ConsumerStatefulWidget {
  const GroupFormScreen({super.key});

  @override
  ConsumerState<GroupFormScreen> createState() => _GroupFormScreenState();
}

class _GroupFormScreenState extends ConsumerState<GroupFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedColor = _colorOptions.first;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(groupRepositoryProvider).create(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            color: _selectedColor,
          );
      ref.invalidate(groupsProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo crear el grupo: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo grupo')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del grupo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa un nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa una descripción' : null,
                ),
                const SizedBox(height: 16),
                Text('Color', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: _colorOptions.map((hex) {
                    final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                    final selected = hex == _selectedColor;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = hex),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 18,
                        child: selected ? const Icon(Icons.check, color: Colors.white) : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSaving ? null : _submit,
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Crear grupo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
