# Problem #4

We'd like to configure the scheduled function with a non-secret value.


## Preparation

- Do the steps in the main `README`.

- Delete any earlier `abc` function (Firebase Console > (project) > `Functions`).

- Have a region that allows deployment (no Problem 2), in `functions/config.js`:

   ```
   const region_v2 = "europe-west2";
   ```

- Have this line disabled (`functions/abc.js`):

   ```
   //secrets: ["ABC"],
   ```
   
   >..or, alternatively, Secret Manager API enabled and such a secret set.
   
- Have these lines enabled (`functions/abc.js`):

   ```
   const confA = defineString('A', { description: 'A something'});
   ```
   
   ```
   console.log("!!!", { confA: confA.value() });
   ```

## Background

The [documentation for Parameterized Configuration](https://firebase.google.com/docs/functions/config-env#params) states:

>the CLI will block deployment unless all parameters have a valid value.

Let's see what happens.


## Steps

```
$ ./deploy
...

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/abc-3011/overview

Error: An unexpected error has occurred.
```

The deployment succeeds. 

Logs show this:

```
!!! { confA: '' }
```

The configuration was never blocked; the user was never asked for a value.

How is this supposed to work?


### Expected

Since there is no `.env` file, deployment would ask the developer to provide a value for `A`, with the given prompt ("A something").

Deployment would *not* proceed, without a value.

### Actual

No asking. Deployed. Empty value.
