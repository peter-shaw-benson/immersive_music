// const enableMidi = WebMidi.enable(function(err) { //check if WebMidi.js is enabled
//     if (err) {
//       console.log("WebMidi could not be enabled.", err);
//     } else {
//       console.log("WebMidi enabled!");
//     }
//     console.log("---");
//     console.log("Inputs Ports: ");
//     for (i = 0; i < WebMidi.inputs.length; i++) {
//       console.log(i + ": " + WebMidi.inputs[i].name);
//     }
//     console.log("---");
//     console.log("Output Ports: ");
//     for (i = 0; i < WebMidi.outputs.length; i++) {
//       console.log(i + ": " + WebMidi.outputs[i].name);
//     }
//     inputSoftware = WebMidi.inputs[0];
//     //listen to all incoming "note on" input events
//     inputSoftware.addListener('noteon', "all",
//       function(e) {
//         //Show what we are receiving
//         console.log("Received 'noteon' message (" + e.note.name + e.note.octave + ") " + e.note.number + ".");
//     //the function you want to trigger on a 'note on' event goes here
        
//         note.currentNote = e.note.number;
//         midiIn();
//       }
//     );
// //   //The note off functionality will need its own event listener
// //   //You don't need to pair every single note on with a note off
// //   inputSoftware.addListener('noteoff', "all",
// //   function(e) {
// //   //Show what we are receiving
// //   console.log("Received 'noteoff' message (" + e.note.name + e.note.octave + ") " + e.note.number + ".");
// //   //the function you want to trigger on a 'note on' event goes here

// //   }
// //   );
//   });