# Firebase tools on DC - bug repro

## Requirements

- You have a Firebase project created, with Cloud Functions enabled (requires "Blaze" plan)

   >Google Analytics can be disabled.

- Docker Desktop installed 
- `npm` v.8
- Node.js 16 or 18

## Problem

`firebase deploy`, when run from under Docker Compose, and with `firebase-debug.log` mapped to the host

- fails with the following, after a successful deploy:

```
Error: EBUSY: resource busy or locked, unlink '/work/firebase-debug.log'
```


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

Error: An unexpected error has occurred.
```

The deployment succeeds, but exiting the process fails.

More details are in `tmp/firebase-debug.log`:

```
$ tail -n 40 tmp/firebase-debug.log
...
[info] i  functions: cleaning up build files... 
[info] 
[info] ✔  Deploy complete! 
[info] 
[info] Project Console: https://console.firebase.google.com/project/abc-3011/overview
[debug] [2022-10-30T16:32:40.762Z] Error: EBUSY: resource busy or locked, unlink '/work/firebase-debug.log'
    at Object.unlinkSync (node:fs:1767:3)
    at process.<anonymous> (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/bin/firebase.js:84:12)
    at process.emit (node:events:525:35)
    at process.exit (node:internal/process/per_thread:190:15)
    at /usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/command.js:105:25
    at runMicrotasks (<anonymous>)
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
[error] 
[error] Error: An unexpected error has occurred.
```

It should not be a problem for `firebase-tools`, returning to OS level, running under Docker (Alpine Linux image) and the log file having been mapped to host.

**Work-around:**

If one enables/disables the `firebase-debug.log` mapping in `docker-compose.yml` on a case-by-case basis, one can debug problems (line enabled) or deploy (line disabled).

This is, however, very clumsy in practise.


## Why this matters?

It may be rare for people to deploy from a sandbox, but it's not an unreasonable use case.

Normally, deployments are done in CI/CD also for this author (and this issue doesn't concern that). In this case, it's a question about onboarding new users to a repo, so they can be up and running as early as possible - doing first deployments without needing to set up CI/CD for it.


---

With this fixed :), let's proceed to [PROBLEM 2](./PROBLEM-2.md).
