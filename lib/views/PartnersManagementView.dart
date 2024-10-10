import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:seneso_admin/models/partenaire_model.dart';
import 'package:seneso_admin/services/PartenaireService.dart';


class PartnersManagementView extends StatefulWidget {
  @override
  _PartnersManagementViewState createState() => _PartnersManagementViewState();
}

class _PartnersManagementViewState extends State<PartnersManagementView> {
  final PartenaireService _partenaireService = PartenaireService();
  List<Partenaire> _partenaires = [];

  @override
  void initState() {
    super.initState();
    _fetchPartenaires();
  }

  Future<void> _fetchPartenaires() async {
    List<Partenaire> partenaires = await _partenaireService.obtenirTousLesPartenaires();
    setState(() {
      _partenaires = partenaires;
    });
  }

  void _showAddEditDialog({Partenaire? partenaire}) {
    // Implementation pour ajouter ou modifier un partenaire
  }

  void _showDeleteDialog(String id) {
    // Implementation pour confirmer la suppression d'un partenaire
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Partenaires'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: DataTable2(
                columns: const [
                  DataColumn(label: Text('Nom')),
                  DataColumn(label: Text('Prénom')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Entreprise')),
                  DataColumn(label: Text('Secteur')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _partenaires.map((partenaire) {
                  return DataRow(cells: [
                    DataCell(Text(partenaire.nom)),
                    DataCell(Text(partenaire.prenom)),
                    DataCell(Text(partenaire.email)),
                    DataCell(Text(partenaire.entreprise)),
                    DataCell(Text(partenaire.secteur)),
                    DataCell(Text(partenaire.type)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: const Color(0xFF2F5B37),
                            onPressed: () => _showAddEditDialog(partenaire: partenaire),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Color(0xFFE05E3E)),
                            onPressed: () => _showDeleteDialog(partenaire.id),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2F5B37),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gestion des Partenaires',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
