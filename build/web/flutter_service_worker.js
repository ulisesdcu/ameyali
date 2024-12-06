'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9e35c2c517864e2df4a9ae9b8aa52ecf",
"assets/AssetManifest.bin.json": "5c9cd788ff5d1a21d6f35379d53d80bc",
"assets/AssetManifest.json": "c7da9f382fbc57a6b00f1d3dc0d76675",
"assets/assets/icon/ameyali.png": "66c5bca351746814a98d36fa63360d19",
"assets/assets/icon/ameyali.svg": "3f756a16319c06f628eea75361719f16",
"assets/assets/icon/ameyalicon.png": "40292d6a82dcb1731c615b550136653f",
"assets/assets/icon/ameyalitext.png": "67977289a2dc7cd284f28b5ec391b3ca",
"assets/assets/icon/ameyalitext.svg": "a782db2460848e733ff96e083634df3c",
"assets/assets/icon/loro_line.svg": "6808d56a546ccdcee6b3f03c036f4d58",
"assets/assets/icon/loro_solid.svg": "b0ae25ffec084551c320e57042c4e790",
"assets/assets/icon/tec.svg": "258b723cf5dbb5eebfce8bc77f7ccd8a",
"assets/assets/icon/tecbanner.svg": "240539280ed931fefac9547f26053b8d",
"assets/assets/icon/x.png": "d6bd021e7f9d57f056bc363825312e7c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "15f8dcd57aaee147bec676da5cdecdde",
"assets/NOTICES": "0945b4452eaa8ac177b08a3019b9db3a",
"assets/packages/auth_buttons/images/default/apple.svg": "dec9066f990b3215aa069595e1185f43",
"assets/packages/auth_buttons/images/default/email.svg": "c6828e2af8812ae296aaf7f929b76e7a",
"assets/packages/auth_buttons/images/default/facebook.svg": "f06ef4966df341c33645b9b172f3f7a7",
"assets/packages/auth_buttons/images/default/github_black.svg": "c47f1e019451022bd4c08b532e26fcbb",
"assets/packages/auth_buttons/images/default/google.svg": "cd8d3cee1ef93bb55ab202d78ad7b34d",
"assets/packages/auth_buttons/images/default/huawei.svg": "55ff4e48fbe273c6317d70304d2dd877",
"assets/packages/auth_buttons/images/default/microsoft.svg": "007e4f3f6c88105755160ebcec91391e",
"assets/packages/auth_buttons/images/default/twitter.svg": "d6af3024c120e0d6806029acf5ffb63c",
"assets/packages/auth_buttons/images/outlined/apple.svg": "f7e040b24c6f6929b75985b77c6fb740",
"assets/packages/auth_buttons/images/outlined/email.svg": "e98f2e3657f36e1be6feaa285107ef2a",
"assets/packages/auth_buttons/images/outlined/facebook.svg": "767dc51c9930d30e0ce2478a7d974bd7",
"assets/packages/auth_buttons/images/outlined/github.svg": "ee0330f29a95eeb06fb58e226e763515",
"assets/packages/auth_buttons/images/outlined/google.svg": "2f8c5d7b7c839625df3b61b09fd4a842",
"assets/packages/auth_buttons/images/outlined/huawei.svg": "251575035ea7c10dc380f51cfcf26630",
"assets/packages/auth_buttons/images/outlined/microsoft.svg": "945571112b39116453dc1b9cd57f8b83",
"assets/packages/auth_buttons/images/outlined/twitter.svg": "aed80dd035d02a257e2669612e88efad",
"assets/packages/auth_buttons/images/secondary/apple.svg": "50d04c649c4fb9fb2523f6aac93bb8a0",
"assets/packages/auth_buttons/images/secondary/email.svg": "6fde813b1adb70ca0c041b705b44fd6a",
"assets/packages/auth_buttons/images/secondary/facebook.svg": "2419544c4fc92fd91236170fb0e481bc",
"assets/packages/auth_buttons/images/secondary/github.svg": "04f160b7dfd8099bcb9f233c5f6420f4",
"assets/packages/auth_buttons/images/secondary/google.svg": "99034cf0b91fa72aefa3e325698dc2aa",
"assets/packages/auth_buttons/images/secondary/huawei.svg": "9de2c5a9d066c43849081d75bdbcae7f",
"assets/packages/auth_buttons/images/secondary/microsoft.svg": "161520a869ea0639540a9bc37865a33f",
"assets/packages/auth_buttons/images/secondary/twitter.svg": "234149a0ae0404a9cd7d77320a604af3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/network_image/assets/profile_default.png": "7ddc665469f6b90b2b53cd66bb668202",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "a57628dbac110198f3ab66c2b1f57d0a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b3bfd1b526612b36a5b426f04d7be3e7",
"/": "b3bfd1b526612b36a5b426f04d7be3e7",
"main.dart.js": "c588eac29ad02a437d6904ac564a208b",
"manifest.json": "777c150ee334a1b5d26df26bd7085459",
"version.json": "7a789430c93677fa2dccf2a82f18005e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
