import 'package:brainmri/models/chat_messages_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM, yyyy');
  return formatter.format(date);
}

void showErrorBottomSheet(BuildContext context, List<String> errors) {
    showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
        return
      Container(
        height: 800,
        color: const Color.fromARGB(255, 31, 33, 38),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
          child:
        SingleChildScrollView(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
                              'Issues found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
      Container(
        alignment: Alignment.center,
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(200, 255, 255, 255), // Add your background color here
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Colors.black, size: 18,),
        ),
      ),
    ],
),
          
const SizedBox(height: 16),
                      Text(
                              'Please correct the following issues before proceeding',
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 32),
Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFCBCB),
        borderRadius: BorderRadius.circular(5),
      ),
      child:
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: errors.map((e) =>
    Text(
      '- ${e}',
      style: TextStyle(
        color: Colors.red[900],
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ).toList(),
),
),
const SizedBox(height: 60),
          ],
        ), 
        ),
        ),
      );
    },
    );
}

void showMixedBottomSheet(BuildContext context, List<String> content, int state, String label, String infoText, Color bgColor, Color txtColor) {
    showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
        return
      Container(
        height: 800,
        color: const Color.fromARGB(255, 31, 33, 38),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
          child:
        SingleChildScrollView(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
                              label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
      Container(
        alignment: Alignment.center,
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(200, 255, 255, 255), // Add your background color here
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Colors.black, size: 18,),
        ),
      ),
    ],
),
          
const SizedBox(height: 16),
                      Text(
                              infoText,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 32),
Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child:
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: content.map((e) =>
    Text(
      '- ${e}',
      style: TextStyle(
        color: txtColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ).toList(),
),
),
const SizedBox(height: 60),
          ],
        ), 
        ),
        ),
      );
    },
    );
}


List<ChatMessageModel> getChatMessagesPrompt(String observation) {

  ChatMessageModel system = ChatMessageModel(
    role: "system", 
    content: "You are a knowledgeable assistant with expertise in medical imaging and diagnostics. You are assisting a user in analyzing Brain MRI scans. Your task is to generate a concise conclusion based on the scan data. You should always ensure that the conclusion is clear and medically accurate. You will be given observation in the following patter: [Observation] <Observation data goes here>. You MUST only return the conclusion."
  );

  List<ChatMessageModel> fewShot = [
    ChatMessageModel(
      role: "user", 
      content: "[Observation]\nScanning technique: T1 FSE-sagital, T2 FLAIR, T2 FSE-axial, T2 FSE-coronar, DWI.\nOn a series of tomograms in the structure of the subcortical and periventricular white matter of the cerebral hemispheres on both sides, multiple round-shaped foci of pathological intensity are asymmetrically determined, with unclear contours, homogeneous hyperintense signal characteristics on T2 VI and T2 FLAIR, with a diameter of 3-10 mm.\nThe basal ganglia are usually located, symmetrical, with clear, even contours, the dimensions are not changed. The MR signal of the nuclei was not changed.\nThe longitudinal fissure of the cerebrum is located centrally. Convexital grooves are moderately widened in the frontotemporal regions on both sides due to atrophy of the adjacent parts of the brain\nThe lateral ventricles are symmetrical, the width of the ventricles at the level of the foramen of Monro is 10 mm on the right, 14 mm on the left. The third ventricle is 4 mm wide. Sylvian aqueduct has not been changed. The fourth ventricle is tent-shaped and not dilated.\nThe corpus callosum is of normal shape and size. The brain stem is without areas of pathological intensity. The cerebellum is of normal shape, the signal characteristics of the white matter are not changed. The width of the cerebellar cortex is reduced due to atrophy. The craniovertebral junction is unchanged.\nThe pituitary gland is moderately flattened, the height in the sagittal projection is 3 mm. The pituitary stalk is located centrally. The chiasma of the optic nerves is located usually, the contours are clear and even. Parasellar cisterns without areas of pathological intensity. The siphons of the internal carotid artery are not changed. The cavernous sinuses of both carotid arteries are symmetrical, with clear, even contours.\nThe shape of the orbital cones on both sides is unchanged. The eyeballs are spherical in shape and of normal size. The signal characteristics of the vitreous body are not changed. The diameter of the optic nerves is not changed. The perineural subarachnoid space of the orbits is moderately diffusely dilated. The extraocular muscles are of normal size, the structure is without pathological signals. Retrobulbar fatty tissue without pathological signals.\nRegion of the cerebellopontine angle: the prevestocochlear nerve is clearly differentiated on both sides. Pneumatization of the mastoid processes of the temporal bones is preserved.\nA cyst with a diameter of 14 mm is identified in the left maxillary sinus. The remaining paranasal sinuses are usually pneumatized."
    ),
    ChatMessageModel(
      role: "assistant", 
      content: "MRI signs of vascular encephalopathy with the presence of multiple ischemic foci and atrophy of the frontotemporal areas on both sides. Left maxillary sinus cyst.\n\nConsultation with a neurologist is recommended.\nConsultation with an otolaryngologist is recommended."
    ),
    ChatMessageModel(
      role: "user", 
      content: "[Observation]\nScanning technique: T1 TSE dark fluid-sagital, T2 TSE dark fluid, T2 TSE-axial, T2 TSE-coronar, DIW.\nOn a series of tomograms, the longitudinal fissure of the cerebrum is located centrally. Convexital grooves are not expanded, their number is not changed. The thickness of the cerebral cortex is preserved, the distribution of gray matter is not disturbed.\nThe lateral ventricles are symmetrical, the width of the ventricles at the level of the foramen of Monro is 5 mm on the right, 6 mm on the left. The third ventricle is 3 mm wide. Sylvian aqueduct has not been changed. The fourth ventricle is tent-shaped and not dilated. The cisterna magna is dilated with retrocerbellar extension.\nThe white matter of the brain has homogeneous isointense signal characteristics; the signal intensity in the periventricular areas is not changed. The basal ganglia are usually located, symmetrical, with clear, even contours, the dimensions are not changed, the MR signal is not changed. The corpus callosum is of normal shape and size. The brain stem is without features. The cerebellum is of normal shape, the signal characteristics of the white matter are not changed. The width of the cerebellar cortex is preserved. The craniovertebral junction is unchanged.\nThe pituitary gland is of normal shape, height in the sagittal projection is 6 mm. The pituitary stalk is located centrally. The chiasma of the optic nerves is located usually, the contours are clear and even. Parasellar cisterns without areas of pathological intensity. The siphons of the internal carotid arteries are not changed. The cavernous sinuses of both carotid arteries are symmetrical, with clear, even contours.\nThe shape of the orbital cones on both sides is unchanged. The eyeballs are spherical in shape and of normal size; the MR signal of the vitreous body is not changed. The diameter of the optic nerves was preserved. The perineural subarachnoid space of the orbits is moderately diffusely dilated. The extraocular muscles are of normal size, the structure is without pathological signals. Retrobulbar fatty tissue without pathological signals.\nRegion of the cerebellopontine angle: the prevestocochlear nerve is clearly differentiated on both sides. Pneumatization of the mastoid processes of both temporal bones is not impaired.\nThe nasal turbinates are moderately hypertrophied, the nasal passages are narrowed. The nasal septum is deviated to the right.\nThe paranasal sinuses are developed correctly. Thickening of the mucous membranes of the cells of the ethmoidal labyrinth and maxillary sinuses is noted."
    ),
    ChatMessageModel(
      role: "assistant", 
      content: "MRI signs of pathological changes in the brain substance were not revealed. Catarrhal changes in the mucous membranes of the cells of the ethmoid labyrinth and maxillary sinuses."
    ),
  ];
  
  ChatMessageModel predict = ChatMessageModel(
    role: "user", 
    content: observation
  );

  List<ChatMessageModel> fullMessage = [
    system,
    ...fewShot,
    predict
  ];

  return fullMessage;
}


    String observationString = """
Scanning technique: T1 FSE-sagital, T2 FLAIR, T2 FSE-axial, T2 FSE-coronar, DWI.
On a series of tomograms in the structure of the subcortical and periventricular white matter of the cerebral hemispheres on both sides, multiple round-shaped foci of pathological intensity are asymmetrically determined, with unclear contours, homogeneous hyperintense signal characteristics on T2 VI and T2 FLAIR, with a diameter of 3-10 mm.
The basal ganglia are usually located, symmetrical, with clear, even contours, the dimensions are not changed. The MR signal of the nuclei was not changed.
The longitudinal fissure of the cerebrum is located centrally. Convexital grooves are moderately widened in the frontotemporal regions on both sides due to atrophy of the adjacent parts of the brain
The lateral ventricles are symmetrical, the width of the ventricles at the level of the foramen of Monro is 10 mm on the right, 14 mm on the left. The third ventricle is 4 mm wide. Sylvian aqueduct has not been changed. The fourth ventricle is tent-shaped and not dilated.
The corpus callosum is of normal shape and size. The brain stem is without areas of pathological intensity. The cerebellum is of normal shape, the signal characteristics of the white matter are not changed. The width of the cerebellar cortex is reduced due to atrophy. The craniovertebral junction is unchanged.
The pituitary gland is moderately flattened, the height in the sagittal projection is 3 mm. The pituitary stalk is located centrally. The chiasma of the optic nerves is located usually, the contours are clear and even. Parasellar cisterns without areas of pathological intensity. The siphons of the internal carotid artery are not changed. The cavernous sinuses of both carotid arteries are symmetrical, with clear, even contours.
The shape of the orbital cones on both sides is unchanged. The eyeballs are spherical in shape and of normal size. The signal characteristics of the vitreous body are not changed. The diameter of the optic nerves is not changed. The perineural subarachnoid space of the orbits is moderately diffusely dilated. The extraocular muscles are of normal size, the structure is without pathological signals. Retrobulbar fatty tissue without pathological signals.
Region of the cerebellopontine angle: the prevestocochlear nerve is clearly differentiated on both sides. Pneumatization of the mastoid processes of the temporal bones is preserved.
A cyst with a diameter of 14 mm is identified in the left maxillary sinus. The remaining paranasal sinuses are usually pneumatized.
""";