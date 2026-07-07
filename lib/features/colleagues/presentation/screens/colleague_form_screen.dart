import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/colleague.dart';
import '../providers/colleague_provider.dart';

class ColleagueFormScreen extends ConsumerStatefulWidget {
  final int groupId;

  const ColleagueFormScreen({super.key, required this.groupId});

  @override
  ConsumerState<ColleagueFormScreen> createState() => _ColleagueFormScreenState();
}

class _ColleagueFormScreenState extends ConsumerState<ColleagueFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  bool _isLeader = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(colleagueRepositoryProvider).create(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            groupId: widget.groupId,
            isLeader: _isLeader,
            address: ColleagueAddress(
              street: _streetController.text.trim(),
              city: _cityController.text.trim(),
              latitude: double.parse(_latController.text.trim()),
              longitude: double.parse(_lngController.text.trim()),
            ),
          );
      ref.invalidate(colleaguesProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo agregar el colaborador: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo colaborador')),
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
                  decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa un nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa un correo' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Teléfono', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa un teléfono' : null,
                ),
                const SizedBox(height: 16),
                Text('Dirección', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(labelText: 'Calle', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa una calle' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'Ciudad', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingresa una ciudad' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latController,
                        decoration: const InputDecoration(labelText: 'Latitud', border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        validator: (v) =>
                            (v == null || double.tryParse(v) == null) ? 'Latitud inválida' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _lngController,
                        decoration: const InputDecoration(labelText: 'Longitud', border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        validator: (v) =>
                            (v == null || double.tryParse(v) == null) ? 'Longitud inválida' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Es líder del grupo'),
                  value: _isLeader,
                  onChanged: (v) => setState(() => _isLeader = v ?? false),
                ),
                const SizedBox(height: 16),
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
                        : const Text('Agregar colaborador'),
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
