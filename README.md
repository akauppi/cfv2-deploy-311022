# Cloud Functions v2, deployed with Docker 🌊

Firebase "v2" Cloud Functions are in public preview (Oct 2022). This is a repo to try to make a scheduled function deploy, from within Docker Compose.

<!--
Bugs noticed:

- ["[Beta] `Cannot read properties of undefined (reading 'service')`, deploying a scheduled function (v2)"](https://github.com/firebase/firebase-functions/issues/1293)
--> 

## Requirements

- You have a Firebase project created, with Cloud Functions enabled (requires "Blaze" plan)

   >Google Analytics can be disabled.

- Docker Desktop installed, and running
- Node.js 16 or 18, `npm` 8

<!--
The repo is developed on macOS, but there shouldn't be anything OS specific.
-->


## Steps

```
$ ./deploy.sh 
```

On the first run, you will be authenticated, to be able to deploy the project.

- Input `No`
- Visit the URL (Alt-double click on Mac will do it)
- Authenticate and
- ..authorize the dockerized `firebase-tools` to deal with  the project

```
i  Firebase optionally collects CLI and Emulator Suite usage and error reporting information to help improve our products. Data is collected in accordance with Google's privacy policy (https://policies.google.com/privacy) and is not used to identify you.

? Allow Firebase to collect CLI and Emulator Suite usage and error reporting information? No

Visit this URL on this device to log in:
https://accounts.google.com/o/oauth2/auth?client_id=563584335869-fgrhgmd47bqnekij5i8b5pr03ho849e6.apps.googleusercontent.com&scope=email%20openid%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloudplatformprojects.readonly%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ffirebase%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform&response_type=code&state=673446174&redirect_uri=http%3A%2F%2Flocalhost%3A9005

Waiting for authentication...

✔  Success! Logged in as akauppi@gmail.com
```

>Note: In this repo, the authentication is kept around for later runs (in `.state/`), so you'll need to do the authentication only once.

Next: 

- choose the project
- give it a compulsory alias (`_` will do)

```
? Which project do you want to add? abc-3011
? What alias do you want to use for this project? (e.g. staging) _

Created alias _ for abc-3011.
Now using alias _ (abc-3011)
```

```
=== Deploying to 'abc-3011'...

i  deploying functions
i  functions: ensuring required API cloudfunctions.googleapis.com is enabled...
i  functions: ensuring required API cloudbuild.googleapis.com is enabled...
i  artifactregistry: ensuring required API artifactregistry.googleapis.com is enabled...
✔  artifactregistry: required API artifactregistry.googleapis.com is enabled
✔  functions: required API cloudfunctions.googleapis.com is enabled
✔  functions: required API cloudbuild.googleapis.com is enabled
i  functions: preparing codebase default for deployment
i  functions: cleaning up build files...

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/abc-3011/overview

...
```

---

Depending on the state of the files, one or multiple problems may turn up..

Proceed to:

- [Not being able to deploy](./PROBLEM-2.md)
- [Not exiting cleanly](./PROBLEM-1.md)
