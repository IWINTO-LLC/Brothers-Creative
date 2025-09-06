import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  String? uId;
  final String name;
  final String description;
  final String quantity;
  final String city;
  final String country;
  final double? cost;
  final double? currentPaied;
  final DateTime? deadLineDate;

  String? state;
  String? currentStage;

  final DateTime? dateTime;
  ProjectModel(
      {required this.id,
      required this.uId,
      required this.name,
      this.state,
      this.currentStage,
      required this.description,
      required this.quantity,
      this.cost = 0,
      this.currentPaied = 0,
      required this.city,
      required this.country,
      this.dateTime,
      this.deadLineDate});
  String get formattedStartDate => THelperFunctions.getFormattedDate(dateTime!);
  static ProjectModel empty() => ProjectModel(
      id: '',
      uId: '',
      name: '',
      state: '',
      currentStage: '',
      city: '',
      country: '',
      quantity: '',
      description: '',
      cost: 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(0),
      deadLineDate: DateTime.fromMillisecondsSinceEpoch(0),
      currentPaied: 0);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UId': uId ?? '',
      'State': state ?? '',
      'CurrentStage': currentStage ?? '',
      'Name': name,
      'Description': description,
      'Quantity': quantity,
      'City': city,
      'Country': country,
      'Cost': cost ?? 0,
      'CurrentPaied': currentPaied ?? 0,
      'DateTime': DateTime.now(),
      'DeadLineDate': deadLineDate
    };
  }

  factory ProjectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ProjectModel(
        id: data['Id'] ?? '',
        uId: data['UId'] ?? '',
        state: data['State'] ?? '',
        currentStage: data['CurrentStage'] ?? '',

        name: data['Name'] ?? '',
        description: data['Description'] ?? '',
        quantity: data['Quantity'] ?? '',
        city: data['City'] ?? '',
        country: data['Country'] ?? '',
        cost: double.parse(data['Cost'].toString()),
        currentPaied: double.parse(data['CurrentPaied'].toString()),
        //dateTime: (data['DateTime'] as Timestamp).toDate(),
        // deadLineDate: data['DeadLineDate'] != null
        //     ? (data['DeadLineDate'] as Timestamp).toDate()
        //     : DateTime.fromMillisecondsSinceEpoch(0),
      );
    }
    return ProjectModel.empty();
  }

  // factory ProjectModel.fromMap(Map<String, dynamic> data) {
  //   return ProjectModel(
  //     id: data['Id'] as String,
  //     uId: data['UId'] as String,
  //     state: data['State'] as String,
  //     name: data['Name'] as String,
  //     description: data['Description'] as String,
  //     quantity: data['Quantity'] as String,
  //     city: data['City'] as String,
  //     // cost: data['Cost'] as double,
  //     //currentPaied: data['CurrentPaied'] as double,
  //     country: data['Country'] as String,
  //     dateTime: (data['DateTime'] as Timestamp).toDate(),
  //     deadLineDate: (data['DeadLineDate'] as Timestamp).toDate(),
  //   );
  // }

  factory ProjectModel.fromDocumentSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProjectModel(
      id: data['Id'] ?? '',
      uId: data['UId'] ?? '',
      state: data['State'] ?? '',
      currentStage: data['CurrentStage'] ?? '',

      name: data['Name'] ?? '',
      description: data['Description'] ?? '',
      quantity: data['Quantity'] ?? '',
      city: data['City'] ?? '',
      country: data['Country'] ?? '',
      //cost: data['Cost'] ?? 0,
      //currentPaied: data['CurrentPaied'] ?? 0,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      deadLineDate: (data['DeadLineDate'] as Timestamp).toDate(),
    );
  }
}
