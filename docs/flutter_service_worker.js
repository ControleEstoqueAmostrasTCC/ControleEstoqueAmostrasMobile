'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0426b3ec36f8d15880efb345ffea54df",
"assets/AssetManifest.json": "1d744ff369ae1ec45a35091dff9d2a50",
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
"assets/assets/images/logo_lagenpe_login.png": "63d2b22a43c98e2dc5b092e0d11513cf",
"assets/assets/images/logo_lagenpe_nobackground.png": "d035e5f43e19935234a7b3449eda732c",
"assets/assets/images/logo_lagenpe_text_nobackground.png": "bcb55b2b9ffbdde74eff78c7b970ab7d",
"assets/assets/images/logo_text_lab.png": "99688a940e656021e7f501ac3137e6c7",
"assets/assets/images/logo_text_lab_nobackground.png": "e70fc87c7ccdfdcf8341f2dea794d3c4",
"assets/assets/images/logo_text_white_lab_nobackground.png": "c482304cb07cf7b94a51cfeb31a9fb3a",
"assets/FontManifest.json": "7c68a8586d8b07d52b9ea0e934213bf7",
"assets/fonts/MaterialIcons-Regular.otf": "761c50e1689d59bc66981dd9e545db21",
"assets/NOTICES": "c20c5c64d033ae46d17f15cdb273bf47",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "c17d858d09fb1c596ef0adbf08872086",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "6d8ab59254a120b76bf53f167e809470",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "d035e5f43e19935234a7b3449eda732c",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "d035e5f43e19935234a7b3449eda732c",
"icons/Icon-512.png": "d035e5f43e19935234a7b3449eda732c",
"icons/Icon-maskable-192.png": "d035e5f43e19935234a7b3449eda732c",
"icons/Icon-maskable-512.png": "d035e5f43e19935234a7b3449eda732c",
"index.html": "83d8c7b94fa565eb049687ec2aa04e67",
"/": "83d8c7b94fa565eb049687ec2aa04e67",
"main.dart.js": "348582450722f657b1c3f9d8a6e5fe4e",
"manifest.json": "bb699ba903f00e40835dbc614267d23a",
"version.json": "963fc93774879b198e22716abd70fe8a"};
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
