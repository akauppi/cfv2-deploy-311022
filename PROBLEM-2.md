# Problem #2

The `abc` scheduled function is enabled and we try to deploy it.

**This succeeds** in region `europe-west2` but does not in region `europe-north1`.

Based on [Cloud Functions Locations](https://cloud.google.com/functions/docs/locations), all regions (31-Oct-22) support "2nd gen" (`europe-north1` and `europe-west4` only support it).

**Expectation:**

- I can deploy a function to any of the listed regions

**Actual**

- Deployment to `europe-north1` fails.

## Preparation

- Do the steps in the main `README`.

- In Firebase Console (online), make sure there is no existing version of `abc` function:

   - [Firebase Console](https://console.firebase.google.com) > (project) > `Functions`

      If there is an instance, delete it.

- See that this line is enabled in `functions/index.js`:

   ```
   export { abc } from './abc.js'
   ```

- See this line is disabled in `functions/abc.js`:

   ```
   //secrets: ["ABC"],   
   ```
   
   >Alternatively, you can manually create the secret `ABC`, in GCP Console.

- See that deployment is to `europe-west2` (`functions/config.js`):

   ```
   const region_v2 = "europe-west2";
   ```


## Steps (that pass)

```
$ ./deploy
...
i  functions: cleaning up build files...

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/abc-3011/overview

Error: An unexpected error has occurred.
```

The deploy should succeed for `europe-west2`. Ignore the `An unexpected error has occurred` at the end (it's the DC mapping problem).

## Steps (that fail)

- Delete the function in Firebase Console (for consistency).

- Change the region to `europe-north1` (`functions/config.js`):

   ```
   const region_v2 = "europe-north1";
   ```

```
$ ./deploy
...
i  functions: creating Node.js 16 function abc(europe-north1)...
HTTP Error: 403, The principal (user or service account) lacks IAM permission "cloudscheduler.jobs.update" for the resource "projects/abc-3011/locations/europe-north1/jobs/firebase-schedule-abc-europe-north1" (or the resource may not exist).

Functions deploy had errors with the following functions:
	abc(europe-north1)
i  functions: cleaning up build files...

Error: There was an error deploying functions
```


### Expected

Since [1] states that all regions support Cloud Functions v2, I would expect to be able to deploy to any region.

`[1]`: [Cloud Functions Locations](https://cloud.google.com/functions/docs/locations) (GCP docs)


### Actual

Deployment to `europe-north1` gives the above error message.

>Also `europe-west4` behaves the same. These are the two regions with ony CF v2 support.

## Why this matters?

It's likely just a glitch in the system.

Since one can deploy to at least some region, the trouble for a developer is not big. Unless they start following the guidance in the error message, setting up IAM permissions manually - without realizing that for some other region, the deploy would just have worked!

Anyways, hope this gets fixed.


