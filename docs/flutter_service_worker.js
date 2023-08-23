'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "f4334eef00f2dcb3ac5fa642b7a6e93a",
"assets/AssetManifest.smcbin": "bde29c8845b83b6ff5f99274b6607835",
"assets/assets/fonts/futura.ttf": "9a1626276b430d216809407c3fbcda75",
"assets/assets/fonts/futura2.ttf": "f9f02ed05aa86534c3842d44cb20d6c4",
"assets/assets/fonts/kabel.ttf": "601b51f2076d708fa30ad2d2085543fc",
"assets/assets/fonts/koblenz-serial-light.otf": "790606df1aff07c59c9a65cf772071b0",
"assets/assets/fonts/lexend.ttf": "a5144e9ee41f343224a9efc3efcbf1bc",
"assets/assets/images/icon_box.png": "e465515c8b849aa48c53ff659d0dfdee",
"assets/assets/images/icon_collection_location.png": "5ef325ad9d65ed4d285ffa2151f82b46",
"assets/assets/images/icon_gender.png": "5c9001c5e83c634b616a39dbede40caf",
"assets/assets/images/icon_procedure.png": "f2e85009d08f9cdb399c9438b42a38ff",
"assets/assets/images/icon_specie.png": "0c867b56e0dd6ccb55f2b3d6006c2dce",
"assets/assets/images/icon_species.png": "3ebf745ac3d20febb2cfea2aea127e70",
"assets/assets/images/icon_tissue.png": "a8f99654590acebebff06d25146271da",
"assets/assets/images/icon_user.png": "1b52d3fa450eaca35da089643ac01446",
"assets/assets/images/logo_image_lab.png": "74d1989250a510b9d6f6822834fa8c0a",
"assets/assets/images/logo_image_lab_nobackground.png": "0399182d6cb3747022a8f1e301b408a3",
"assets/assets/images/logo_lab.jpg": "ec6227ee8c10797271eb0493e28a62dd",
"assets/assets/images/logo_lagenpe_nobackground.png": "d035e5f43e19935234a7b3449eda732c",
"assets/assets/images/logo_lagenpe_text_nobackground.png": "bcb55b2b9ffbdde74eff78c7b970ab7d",
"assets/assets/images/logo_text_lab.png": "99688a940e656021e7f501ac3137e6c7",
"assets/assets/images/logo_text_lab_nobackground.png": "e70fc87c7ccdfdcf8341f2dea794d3c4",
"assets/assets/images/logo_text_white_lab_nobackground.png": "c482304cb07cf7b94a51cfeb31a9fb3a",
"assets/FontManifest.json": "7e471070e761da943fdc78cca85616f4",
"assets/fonts/MaterialIcons-Regular.otf": "2cbb49f85046c9c74135953078f288ef",
"assets/NOTICES": "b7af74b22f2f18e9bcf8cd02a3f842cd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "cca8770efb15597740e9309057f9a184",
"/": "cca8770efb15597740e9309057f9a184",
"main.dart.js": "d63926d0d68f6fc208f1c99eb05956dd",
"manifest.json": "bb699ba903f00e40835dbc614267d23a",
"version.json": "0e81faba50b28a3d36ca0c7323570052"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
