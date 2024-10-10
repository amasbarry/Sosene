import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:seneso_admin/models/admin_model.dart';
import 'package:seneso_admin/services/AdminService.dart';

class AdministrateurListScreen extends StatefulWidget {
  @override
  _AdministrateurListScreenState createState() => _AdministrateurListScreenState();
}

class _AdministrateurListScreenState extends State<AdministrateurListScreen> {
  final AdministrateurService _administrateurService = AdministrateurService();
  List<Administrateur> _administrateurs = [];
  bool _isLoading = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchAdministrateurs();
  }

  Future<void> _fetchAdministrateurs() async {
    List<Administrateur> admins = await _administrateurService.getTousLesAdministrateurs();
    setState(() {
      _administrateurs = admins;
      _isLoading = false;
    });
  }

  Future<void> _showAddEditDialog({Administrateur? admin}) async {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nomController = TextEditingController(text: admin?.nom ?? '');
    final TextEditingController _prenomController = TextEditingController(text: admin?.prenom ?? '');
    final TextEditingController _emailController = TextEditingController(text: admin?.email ?? '');
    final TextEditingController _roleController = TextEditingController(text: admin?.role ?? '');
    final TextEditingController _privilegesController = TextEditingController(text: admin?.privileges ?? '');

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(maxWidth: 700, maxHeight: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  admin == null ? 'Ajouter Administrateur' : 'Modifier Administrateur',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F5B37),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(_nomController, 'Nom', Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(_prenomController, 'Prénom', Icons.person_outline),
                      const SizedBox(height: 15),
                      _buildTextField(_emailController, 'Email', Icons.email),
                      const SizedBox(height: 15),
                      _buildTextField(_roleController, 'Rôle', Icons.badge),
                      const SizedBox(height: 15),
                      _buildTextField(_privilegesController, 'Privilèges', Icons.security),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler', style: TextStyle(color: Color(0xFFE05E3E))),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final newAdmin = Administrateur(
                            id: admin?.id ?? '',
                            nom: _nomController.text,
                            prenom: _prenomController.text,
                            email: _emailController.text,
                            motDePasse: admin?.motDePasse ?? 'defaultPass',
                            role: _roleController.text,
                            privileges: _privilegesController.text,
                          );
                          if (admin == null) {
                            await _administrateurService.ajouterAdministrateur(newAdmin);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Administrateur ajouté avec succès')),
                            );
                          } else {
                            await _administrateurService.updateAdministrateur(admin.id, newAdmin);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Administrateur modifié avec succès')),
                            );
                          }
                          _fetchAdministrateurs();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(admin == null ? 'Ajouter' : 'Modifier'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFF2F5B37),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF2F5B37)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Color(0xFF2F5B37)),
      ),
      validator: (value) => value!.isEmpty ? 'Entrez $label' : null,
    );
  }

  Future<void> _showDeleteDialog(String adminId) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Confirmer la suppression'),
        content: const Text('Voulez-vous vraiment supprimer cet administrateur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: Color(0xFFE05E3E))),
          ),
          ElevatedButton(
            onPressed: () async {
              await _administrateurService.supprimerAdministrateur(adminId);
              _fetchAdministrateurs();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Administrateur supprimé avec succès')),
              );
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFFE05E3E),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Administrateurs'),
        backgroundColor: Color(0xFF2F5B37),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEditDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.grey.withOpacity(0.3))],
                      ),
                      child: DataTable2(
                        columnSpacing: 12,
                        minWidth: 600,
                        columns: const [
                          DataColumn2(label: Text('Nom', style: TextStyle(fontWeight: FontWeight.bold)), size: ColumnSize.L),
                          DataColumn2(label: Text('Prénom', style: TextStyle(fontWeight: FontWeight.bold)), size: ColumnSize.M),
                          DataColumn2(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)), size: ColumnSize.L),
                          DataColumn2(label: Text('Rôle', style: TextStyle(fontWeight: FontWeight.bold)), size: ColumnSize.M),
                          DataColumn2(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)), size: ColumnSize.S),
                        ],
                        rows: _administrateurs
                            .where((admin) =>
                                admin.nom.toLowerCase().contains(_searchText) ||
                                admin.prenom.toLowerCase().contains(_searchText) ||
                                admin.email.toLowerCase().contains(_searchText))
                            .map(
                              (admin) => DataRow(
                                cells: [
                                  DataCell(Text(admin.nom)),
                                  DataCell(Text(admin.prenom)),
                                  DataCell(Text(admin.email)),
                                  DataCell(Text(admin.role)),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Color(0xFFE58730)),
                                          onPressed: () => _showAddEditDialog(admin: admin),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Color(0xFFE05E3E)),
                                          onPressed: () => _showDeleteDialog(admin.id),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Liste Administrateurs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2F5B37)),
        ),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              labelText: 'Rechercher...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: Icon(Icons.search, color: Color(0xFFE58730)),
            ),
          ),
        ),
      ],
    );
  }
}
