/*
* functions/index.js
*
* Cloud Functions entry point.
*
* References:
*   - Call functions from your app (Firebase docs)
*     -> https://firebase.google.com/docs/functions/callable
*   - Add the Firebase Admin SDK to your server (Firebase docs)
*     -> https://firebase.google.com/docs/admin/setup
*   - Cloud Functions v2 public preview
*     -> https://firebase.google.com/docs/functions/beta
*/
import { EMULATION, databaseURL } from "./config.js";    // string?

// 'firebase-tools' (4.0.1) provides 'databaseURL' under emulation, regardless whether it's actually usable or not.
// We counteract that.
//
const reallyHaveDatabaseURL = (!EMULATION || process.env["FIREBASE_DATABASE_EMULATOR_HOST"]) && databaseURL;

//---
// abc
//
//export const abc = !EMULATION && await import("./abc.js").then( mod => mod.abc() );
export { abc } from './abc.js'

