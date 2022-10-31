# Problem #2 (unrelated)

In this case, the `abc` scheduled function is enabled and we try to deploy it.

## Requirements

Same as in `master` branch's `README`.


## Steps

```
$ ./deploy
```

```
$ tail -n 20 firebase-debug.log
...
[debug] [2022-10-31T06:20:29.887Z] TypeError: Cannot read properties of undefined (reading 'service')
    at /usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/functions/backend.js:198:113
    at Array.map (<anonymous>)
    at loadExistingBackend (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/functions/backend.js:198:69)
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at async Object.existingBackend (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/functions/backend.js:174:9)
    at async prepare (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/functions/prepare.js:138:115)
    at async chain (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/index.js:35:9)
    at async deploy (/usr/local/share/.config/yarn/global/node_modules/firebase-tools/lib/deploy/index.js:79:5)
[error] 
[error] Error: An unexpected error has occurred.
```

### Expected

- If our code does something wrong, getting an error message with guidance.

### Actual

`TypeError: Cannot read properties of undefined (reading 'service')`?

Note: Above that error, there is a portion that may shine light to the problems:

```
[{"severity":"ERROR","type":"CloudRunServiceNotFound","message":"Cloud Run service projects/abc-3011/locations/europe-north1/services/abc for the function was not found. The function will not work correctly. Please redeploy."}]
```

Again, as a developer, I would like to see guidance, or for Firebase CLI to enable necessary access rights, as it does for many GCP details.

