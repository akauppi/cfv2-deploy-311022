# No Problem #3

We'd like to use a secret in the `abc` scheduled function.

## Preparation

- Do the steps in the main `README`.

- Have a region that allows deployment (no Problem 2), in `functions/config.js`:

   ```
   const region_v2 = "europe-west2";
   ```

- Have this line enabled (`functions/abc.js`):

   ```
   secrets: ["ABC"],
   ```

## Steps

```
$ ./deploy
...

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/abc-3011/overview

Error: An unexpected error has occurred.
```

Deployment should succeed. :) Ignore the `An unexpected error has occurred` (it's the DC file mapping rejected by Firebase CLI, described elsewhere).
