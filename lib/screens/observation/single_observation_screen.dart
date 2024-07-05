import 'package:brainmri/models/observation_model.dart';
import 'package:brainmri/models/patients_model.dart';
import 'package:brainmri/screens/observation/components/custom_search.dart';
import 'package:brainmri/screens/observation/components/observation_card.dart';
import 'package:brainmri/screens/observation/components/single_observation_bottom_sheet.dart';
import 'package:brainmri/screens/user/user_epics.dart';
import 'package:brainmri/screens/user/user_reducer.dart';
import 'package:brainmri/store/app_store.dart';
import 'package:brainmri/utils/refreshable.dart';
import 'package:brainmri/utils/shared.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


class ObservationsScreen extends StatefulWidget {
  const ObservationsScreen({Key? key, 
  }) : super(key: key);

  @override
  State<ObservationsScreen> createState() => _ObservationsScreenState();
}

class _ObservationsScreenState extends State<ObservationsScreen> {
  List<ObservationModel> filteredObservations = [];
  String labelText = "Brain MRI";

  var state = store.state.appState.userState;

  @override
  void initState() {
    super.initState();
  }

  void reFetchData()  {
            if (store.state.appState.userState.patientsAllObservations != null) {
          if (store.state.appState.userState.patientsAllObservations!.observations != null) {

                print('store.state.appState.userState.patientsAllObservations!.id!: ${store.state.appState.userState.patientsAllObservations!.id!}');
                StoreProvider.of<GlobalState>(context).dispatch(FetchPatientAllObservations(store.state.appState.userState.patientsAllObservations!.id!));
                print('ObservationsScreen onInit store.state.appState.userState.patientsAllObservations!.id!, ${store.state.appState.userState.patientsAllObservations!.id!}');
setState(() {
              filteredObservations = store.state.appState.userState.patientsAllObservations!.observations!;
});
          }
        }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    reFetchData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  void showObservation(o) {
    showObservationBottomSheet(context, o, labelText, state.patientsAllObservations!.id!);
  }

  void updateFilteredObservations(String filter) {
    setState(() {
      filteredObservations = store.state.appState.userState.patientsAllObservations!.observations!.where((observation) {
        final observationDateStr = formatDate(DateTime.parse(observation.observedAt!.toString())).toLowerCase();
        final radiologistNameLower = observation.radiologistName!.toLowerCase();
        final labelTextLower = labelText.toLowerCase();
        final isApprovedStr = observation.conclusion!.isApproved! ? 'approved' : 'pending';
        final filterLower = filter.toLowerCase();

        return observationDateStr.contains(filterLower) ||
            radiologistNameLower.contains(filterLower) ||
            labelTextLower.contains(filterLower) ||
            isApprovedStr.contains(filterLower);
      }).toList();
    });
  }

    TextEditingController conclusionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 33, 38),
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: const Color.fromARGB(255, 23, 24, 28),
        backgroundColor: const Color.fromARGB(255, 23, 24, 28),
        title: const Text(
          'Observations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: 

      StoreConnector<GlobalState, UserState>(
      onInit: (store) {
        if (store.state.appState.userState.patientsAllObservations != null) {
          if (store.state.appState.userState.patientsAllObservations!.observations != null) {

                print('store.state.appState.userState.patientsAllObservations!.id!: ${store.state.appState.userState.patientsAllObservations!.id!}');
                store.dispatch(FetchPatientAllObservations(store.state.appState.userState.patientsAllObservations!.id!));
                print('ObservationsScreen onInit store.state.appState.userState.patientsAllObservations!.id!, ${store.state.appState.userState.patientsAllObservations!.id!}');
              filteredObservations = store.state.appState.userState.patientsAllObservations!.observations!;
          }
        }
      },
      converter: (appState) => appState.state.appState.userState,
      builder: (context, userState) {
        
        return
              Padding(padding: 
      const EdgeInsets.all(16),
      child:
        Column(children: [
              CustomSearchInput(
                readOnly: userState.patientsAllObservations!.observations == null,
                    onSearchChanged: userState.patientsAllObservations!.observations == null ? (String value) {print('null');} : updateFilteredObservations,
                  ),
    const SizedBox(height: 16),

    Expanded(child: 
    Refreshable(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: 
            
            userState.isObservationsListLoading ?

            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF232428)), // Change the progress color
                backgroundColor: Color(0xFFC3C3C3), // Change the background color
              ),
            ) :
            
            filteredObservations.isNotEmpty ?

  GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 1,
    ),
    itemCount: filteredObservations.length,
    itemBuilder: (context, index) {
      print('filteredObservations.length, ${filteredObservations.length}');

      return ObservationCard(
                        observationDate: filteredObservations[index].observedAt!.toString(),
                        radiologistName: filteredObservations[index].radiologistName!,
                        labelText: labelText,
                        isApproved: filteredObservations[index].conclusion!.isApproved!,
                        onTap: () {
                          showObservation(filteredObservations[index]);
                        },
                      );
      } 
  ) :
        Center(child: Text("No data", style: TextStyle(color: Colors.white,),)),
  ),
  ),
        ],)
      );
  }
    ),
    );
  }
}
