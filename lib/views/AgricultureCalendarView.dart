import 'package:flutter/material.dart';
import 'package:seneso_admin/services/CalendrierAgricoleService.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/calendrier_agricole.dart';

class AgriculturalCalendarView extends StatefulWidget {
  const AgriculturalCalendarView({super.key});

  @override
  _AgriculturalCalendarViewState createState() => _AgriculturalCalendarViewState();
}

class _AgriculturalCalendarViewState extends State<AgriculturalCalendarView> {
  final CalendrierAgricoleService _service = CalendrierAgricoleService();
  List<CalendrierAgricole> evenements = [];
  bool isLoading = false; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    setState(() {
      isLoading = true; // Affiche l'animation de chargement
    });
    try {
      evenements = await _service.recupererEvenements();
    } catch (e) {
      // Gérez les erreurs ici si nécessaire
    } finally {
      setState(() {
        isLoading = false; // Cache l'animation de chargement
      });
    }
  }

  CalendarDataSource _getCalendarDataSource() {
    return MyCalendarDataSource(evenements);
  }

  void _showAddEventDialog() {
    final TextEditingController titreController = TextEditingController();
    final TextEditingController typeCultureController = TextEditingController();
    final TextEditingController regionController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime dateDebut = DateTime.now();
    DateTime dateFin = DateTime.now().add(Duration(days: 1));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un Événement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titreController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: typeCultureController,
                  decoration: const InputDecoration(labelText: 'Type de Culture'),
                ),
                TextField(
                  controller: regionController,
                  decoration: const InputDecoration(labelText: 'Région'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                Text('Date de Début: ${dateDebut.toLocal()}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dateDebut,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != dateDebut) {
                      setState(() {
                        dateDebut = pickedDate;
                      });
                    }
                  },
                  child: const Text('Sélectionner la Date de Début'),
                ),
                const SizedBox(height: 10),
                Text('Date de Fin: ${dateFin.toLocal()}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dateFin,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != dateFin) {
                      setState(() {
                        dateFin = pickedDate;
                      });
                    }
                  },
                  child: const Text('Sélectionner la Date de Fin'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () {
                _addEvent(titreController.text, typeCultureController.text,
                    regionController.text, descriptionController.text, dateDebut, dateFin);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addEvent(String titre, String typeCulture, String region, String description, DateTime dateDebut, DateTime dateFin) async {
    final String id = DateTime.now().toString(); // Génération d'un ID unique
    CalendrierAgricole nouvelEvenement = CalendrierAgricole(
      id: id,
      titre: titre,
      typeCulture: typeCulture,
      region: region,
      dateDebut: dateDebut,
      dateFin: dateFin,
      description: description,
    );
    await _service.ajouterEvenement(nouvelEvenement);
    setState(() {
      evenements.add(nouvelEvenement); // Ajout de l'événement à la liste
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier Agricole'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddEventDialog,
          ),
        ],
      ),
      body: Row(
        children: [
          // Partie gauche : le calendrier
          Expanded(
            flex: 2,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SfCalendar(
                    view: CalendarView.month,
                    dataSource: _getCalendarDataSource(),
                    onTap: (details) {
                      if (details.targetElement == CalendarElement.calendarCell) {
                        // Logique pour afficher les détails de l'événement si disponible
                      }
                    },
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class MyCalendarDataSource extends CalendarDataSource {
  MyCalendarDataSource(List<CalendrierAgricole> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].dateDebut; // Corrigez ici
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].dateFin; // Corrigez ici
  }

  @override
  String getSubject(int index) {
    return appointments![index].titre; // Corrigez ici
  }
}
