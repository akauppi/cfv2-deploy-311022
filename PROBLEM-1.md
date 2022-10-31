# Problem #1

This problem doesn't need a scheduled function to be defined.

## Preparation

Comment out these lines in `functions/index.js`:

```
//export const abc = !EMULATION && await import("./abc.js").then( mod => mod.abc() );
//export { abc } from './abc.js'
```

Follow steps in main `README`, to authenticate (and try deploying).

## Steps

```
$ ./deploy.sh
```

### Expected

The script will succeed.

### Actual

```
...
Error: An unexpected error has occurred.
```

The deployment succeeds, but exiting the process fails.

More details are in `firebase-debug.log`:

```
$ tail -n 40 firebase-debug.log
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

It should not be a problem for `firebase-tools`, to be run under Docker (Alpine Linux image) and the log file having been mapped to host.

**Work-around:**

If one enables/disables the `firebase-debug.log` mapping in `docker-compose.yml` on a case-by-case basis, one can debug problems (line enabled) or deploy (line disabled).

This is, however, very clumsy in practise.


## Why this matters?

It may be rare for people to deploy from a sandbox, but it's not an unreasonable use case.

In this case, it's about onboarding new users to a repo, so they can be up and running as early as possible - doing first deployments without needing to set up CI/CD for it.

