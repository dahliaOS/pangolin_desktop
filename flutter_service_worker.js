'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/icons/notes.png": "5644e3fe7f2f7601a6afdba1f1e17b73",
"assets/assets/icons/graft.png": "044c55245afc351fee36122f676369de",
"assets/assets/icons/root.png": "edb147b20b24112a578f11f4fbdd24f3",
"assets/assets/icons/clock.png": "81ca934d721ad96518209fd99b627908",
"assets/assets/icons/logs.png": "e312999c04f678ff5941d66718ef6cbf",
"assets/assets/icons/files.png": "6c5019286c21611abebc9e9b1086be03",
"assets/assets/icons/calculator.png": "b5d2f4da128fd5a0eed0ed52a5ac9147",
"assets/assets/icons/terminal.png": "524019d8d97ea6c4ccd3db664375e4da",
"assets/assets/icons/web.png": "a26b78a08fe2da40a81e3c837a60cede",
"assets/assets/icons/welcome-info.png": "cf9e894cfddbcd39a5efaf9f29186ba9",
"assets/assets/icons/settings.png": "d5be1c564f8564d8c0a6f86057b01f2a",
"assets/assets/icons/photos.png": "9b2ee870807ea18761ff4bf308897394",
"assets/assets/icons/task.png": "548e313c465c5caf31cad9d574119016",
"assets/assets/json/visualData.json": "67badc4c58f9d11fb0fb78573b7f5067",
"assets/assets/images/logos/dahliaOS-logo.png": "02f1c9f097b0a80bf77544d0a382d990",
"assets/assets/images/logos/dahliaOS-modern.png": "027dab4f9150bb5769a7714cfa725033",
"assets/assets/images/wallpapers/Bubbles_wallpaper.png": "46b9730c0c07198404a23bc13c3f385e",
"assets/assets/images/wallpapers/Three_Bubbles.png": "bc437cfc4c4d2cb8e036b9aaab065198",
"assets/assets/images/wallpapers/Gradient_logo_wallpaper.png": "cc93d4e28412dbdab2608ff625a4492e",
"assets/assets/images/wallpapers/forest.jpg": "bb9971fadf446779b9f29204180bcf72",
"assets/assets/images/wallpapers/dahliaOS_white_wallpaper.png": "cb8d99e02029bd75eff508d3fdd56c37",
"assets/assets/images/wallpapers/Mountains_wallpaper.png": "6e7975b97f96ede66ace575fad741cc6",
"assets/assets/images/wallpapers/mountain.jpg": "7fca0b04f5582bd15144f8ede952aa17",
"assets/assets/images/wallpapers/dahliaOS_white_logo_pattern_wallpaper.png": "6493c5cf40d2b4f4edc55202ee94b5a7",
"assets/assets/images/wallpapers/modern.png": "1c517d39617b8a04f7ea0b3655589dce",
"assets/assets/images/other/null.png": "74c2d1eb37ec4a0b1a5b45edc7e67082",
"assets/assets/images/other/Desktop.png": "c7a2ea58837eed2fcaa17acde26e5941",
"assets/AssetManifest.json": "26c42962dc54ccfd4bd1ab3ed53057b1",
"assets/FontManifest.json": "be0c49e44b8956b73e873e19aaef9157",
"assets/global/assets/NoiseAsset_256X256_PNG.png": "81f27726c45346351eca125bd062e9a7",
"assets/global/assets/NoiseAsset.txt": "0957c5fa9ab4897fb4d9005b3343d2cb",
"assets/fonts/firacode/FiraCode-Medium.ttf": "38989befe49ab72063b68518a4531cc8",
"assets/fonts/firacode/FiraCode-Bold.ttf": "01f3d4803613ee9556769509a85dba50",
"assets/fonts/firacode/FiraCode-Retina.ttf": "2f7bfe28b1954979587e0a79dcae2bef",
"assets/fonts/firacode/FiraCode-Light.ttf": "93f948964a49886cbcc390bd52ecbf36",
"assets/fonts/inter/Inter-SemiBold.ttf": "ec60b23f3405050f546f4765a9e90fec",
"assets/fonts/inter/Inter-Bold.ttf": "91e5aee8f44952c0c14475c910c89bb8",
"assets/fonts/inter/Inter-ExtraBold.ttf": "bd9525f1099e9f5845f6aef2956e9fb8",
"assets/fonts/inter/Inter-ExtraLight.ttf": "909744bbb5a7ede41ce522a1507e952c",
"assets/fonts/inter/Inter-Thin.ttf": "35b7cf4cc47ac526b745c7c29d885f60",
"assets/fonts/inter/Inter-Regular.ttf": "515cae74eee4925d56e6ac70c25fc0f6",
"assets/fonts/inter/Inter-Black.ttf": "5f2ce7df2a2e8570f4c32a44414df347",
"assets/fonts/inter/Inter-Light.ttf": "6ffbefc66468b90d7af1cbe1e9f13430",
"assets/fonts/CustomIcons.ttf": "cc73b5bfddd6e04d22b8bdc9fae42b87",
"assets/fonts/dm-sans/DMSans-MediumItalic.ttf": "a2a143d61d86a67e5e77cf43fd0a4e59",
"assets/fonts/dm-sans/DMSans-Bold.ttf": "071853031a2175ada019db9e6fd1585c",
"assets/fonts/dm-sans/DMSans-Italic.ttf": "b89267290c0df2e03ae1b60bd14109c8",
"assets/fonts/dm-sans/DMSans-BoldItalic.ttf": "a300c77208334f8ad8b2fc95ee2040ce",
"assets/fonts/dm-sans/DMSans-Medium.ttf": "fbbc5a515be4021a9a36f048e25ad396",
"assets/fonts/dm-sans/DMSans-Regular.ttf": "3e7f038b85daa739336e4a3476c687f2",
"assets/fonts/lato/Lato-Italic.ttf": "7582e823ef0d702969ea0cce9afb326d",
"assets/fonts/lato/Lato-Bold.ttf": "85d339d916479f729938d2911b85bf1f",
"assets/fonts/lato/Lato-BoldItalic.ttf": "f98d18040a766b7bc4884b8fcc154550",
"assets/fonts/lato/Lato-Light.ttf": "2fe27d9d10cdfccb1baef28a45d5ba90",
"assets/fonts/lato/Lato-Regular.ttf": "2d36b1a925432bae7f3c53a340868c6e",
"assets/fonts/lato/Lato-LightItalic.ttf": "4d80ac573c53d192dafd99fdd6aa01e9",
"assets/fonts/lato/Lato-Black.ttf": "e631d2735799aa943d93d301abf423d2",
"assets/fonts/lato/Lato-Thin.ttf": "9a77fbaa85fa42b73e3b96399daf49c5",
"assets/fonts/lato/Lato-BlackItalic.ttf": "2e26a9163cb4974dcba1bea5107d4492",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/packages/global/assets/NoiseAsset_256X256_PNG.png": "81f27726c45346351eca125bd062e9a7",
"assets/packages/global/assets/NoiseAsset.txt": "0957c5fa9ab4897fb4d9005b3343d2cb",
"assets/packages/task_manager/assets/images/icons/PNG/notes.png": "5644e3fe7f2f7601a6afdba1f1e17b73",
"assets/packages/task_manager/assets/images/icons/PNG/messages.png": "004c87d98d7fb5ed52f8d79898d88ae6",
"assets/packages/task_manager/assets/images/icons/PNG/graft.png": "11cbd7517f73ff7e1df235eb17279db8",
"assets/packages/task_manager/assets/images/icons/PNG/root.png": "edb147b20b24112a578f11f4fbdd24f3",
"assets/packages/task_manager/assets/images/icons/PNG/twitter.png": "4607476796cc93ca75cfeccf2661fd1a",
"assets/packages/task_manager/assets/images/icons/PNG/telegram.png": "36218d3af50dbc1d0240879a5f966fc4",
"assets/packages/task_manager/assets/images/icons/PNG/software.png": "960cdf38b0daacbf2d3316355c3f78f1",
"assets/packages/task_manager/assets/images/icons/PNG/music.png": "91e7695e656f380f48df79ef8616b205",
"assets/packages/task_manager/assets/images/icons/PNG/clock.png": "81ca934d721ad96518209fd99b627908",
"assets/packages/task_manager/assets/images/icons/PNG/logs.png": "e312999c04f678ff5941d66718ef6cbf",
"assets/packages/task_manager/assets/images/icons/PNG/help.png": "149ba5f0862946faea4d5744619ba607",
"assets/packages/task_manager/assets/images/icons/PNG/debian.png": "527552dd24e4cd27bfb4be63b2c454c4",
"assets/packages/task_manager/assets/images/icons/PNG/discord.png": "103e593c79206b9cd16fef562cc7ac32",
"assets/packages/task_manager/assets/images/icons/PNG/wallpaper.png": "5d490931a734ec44fd88bdc9b947d9ab",
"assets/packages/task_manager/assets/images/icons/PNG/theme.png": "1b065d813d384c82002793b1b92b0b85",
"assets/packages/task_manager/assets/images/icons/PNG/files.png": "6c5019286c21611abebc9e9b1086be03",
"assets/packages/task_manager/assets/images/icons/PNG/reddit.png": "9b1ba56edec14b468ecf4b3913a7794d",
"assets/packages/task_manager/assets/images/icons/PNG/github.png": "bd64ef0f18cf6b627dc8390a96aed2bd",
"assets/packages/task_manager/assets/images/icons/PNG/Gmail-icon.png": "dfcbd586c56f73e343b25b3af12491c1",
"assets/packages/task_manager/assets/images/icons/PNG/social.png": "e0f4fcf882cc23ed646290fbfc859986",
"assets/packages/task_manager/assets/images/icons/PNG/calculator.png": "b5d2f4da128fd5a0eed0ed52a5ac9147",
"assets/packages/task_manager/assets/images/icons/PNG/terminal.png": "524019d8d97ea6c4ccd3db664375e4da",
"assets/packages/task_manager/assets/images/icons/PNG/fuchsia.png": "687e3a9bac810885c97028229adf3ac2",
"assets/packages/task_manager/assets/images/icons/PNG/instagram.png": "60ef178e1c7539c232abfad28d2bdaeb",
"assets/packages/task_manager/assets/images/icons/PNG/web.png": "a26b78a08fe2da40a81e3c837a60cede",
"assets/packages/task_manager/assets/images/icons/PNG/software-shared.png": "868fe8e3d80b189e934220391a09dfaa",
"assets/packages/task_manager/assets/images/icons/PNG/welcome-info.png": "cf9e894cfddbcd39a5efaf9f29186ba9",
"assets/packages/task_manager/assets/images/icons/PNG/credits.png": "8eb3c439b19df88fb7643c395bc983b2",
"assets/packages/task_manager/assets/images/icons/PNG/welcome.png": "3ba49cfcd43616510002a9431b90bdb5",
"assets/packages/task_manager/assets/images/icons/PNG/grey-drag.png": "af96264233287efd9efbf4ee2954fc67",
"assets/packages/task_manager/assets/images/icons/PNG/menu.png": "e824461dd4c3e943b4b1da1817290f73",
"assets/packages/task_manager/assets/images/icons/PNG/android.png": "27a703eacba2bbfed57346b32b7af9b1",
"assets/packages/task_manager/assets/images/icons/PNG/settings.png": "d5be1c564f8564d8c0a6f86057b01f2a",
"assets/packages/task_manager/assets/images/icons/PNG/photos.png": "9b2ee870807ea18761ff4bf308897394",
"assets/packages/task_manager/assets/images/icons/PNG/authenticator.png": "35096977d24eb89d0c661b0956567642",
"assets/packages/task_manager/assets/images/icons/PNG/macos.png": "2799296e4d4831c96c2b1b205d0ae796",
"assets/packages/task_manager/assets/images/icons/PNG/facebook.png": "d54e509f31d051140eca9e8d7b34ec40",
"assets/packages/task_manager/assets/images/icons/PNG/ubuntu.png": "dc5596b1ded46cc5b61f74b860e98964",
"assets/packages/task_manager/assets/images/icons/PNG/task.png": "548e313c465c5caf31cad9d574119016",
"assets/packages/task_manager/assets/images/icons/PNG/developer.png": "14f413a0c0ba35af4fe5bcc04ebf2820",
"assets/packages/task_manager/assets/images/icons/PNG/note_mobile.png": "5bc75d1575688657c59eeab91631d473",
"assets/packages/task_manager/assets/images/icons/PNG/disks.png": "b8c23e9bf62238d900b958540be4f236",
"assets/packages/task_manager/assets/images/icons/PNG/phone.png": "de209128b7b3241f65b8b5c117c10190",
"assets/packages/files/lib/assets/icons/folder.png": "bf696664ea09b8cd4e2eed65993be06e",
"assets/packages/files/lib/assets/icons/file.png": "2b4409f3e88456ccc7a4551dceb17b14",
"assets/packages/media/assets/examples/example2.mp4": "1a32e5e5d2f61e89b69a1c470e250b77",
"assets/packages/media/assets/examples/example1.mp4": "bfa9d457805f81be518634ca5726e552",
"assets/packages/media/assets/examples/logo.png": "c7040497f3c2f593a3fc7417ca6e782c",
"assets/packages/easy_localization/i18n/en.json": "5bd908341879a431441c8208ae30e4fd",
"assets/packages/easy_localization/i18n/en-US.json": "5bd908341879a431441c8208ae30e4fd",
"assets/packages/easy_localization/i18n/ar-DZ.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/packages/easy_localization/i18n/ar.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/packages/welcome/assets/images/icons/PNG/messages.png": "004c87d98d7fb5ed52f8d79898d88ae6",
"assets/packages/welcome/assets/images/icons/PNG/twitter.png": "4607476796cc93ca75cfeccf2661fd1a",
"assets/packages/welcome/assets/images/icons/PNG/telegram.png": "36218d3af50dbc1d0240879a5f966fc4",
"assets/packages/welcome/assets/images/icons/PNG/discord.png": "103e593c79206b9cd16fef562cc7ac32",
"assets/packages/welcome/assets/images/icons/PNG/theme.png": "1b065d813d384c82002793b1b92b0b85",
"assets/packages/welcome/assets/images/icons/PNG/reddit.png": "9b1ba56edec14b468ecf4b3913a7794d",
"assets/packages/welcome/assets/images/icons/PNG/github.png": "bd64ef0f18cf6b627dc8390a96aed2bd",
"assets/packages/welcome/assets/images/icons/PNG/social.png": "e0f4fcf882cc23ed646290fbfc859986",
"assets/packages/welcome/assets/images/icons/PNG/instagram.png": "60ef178e1c7539c232abfad28d2bdaeb",
"assets/packages/welcome/assets/images/icons/PNG/software-shared.png": "868fe8e3d80b189e934220391a09dfaa",
"assets/packages/welcome/assets/images/icons/PNG/welcome-info.png": "cf9e894cfddbcd39a5efaf9f29186ba9",
"assets/packages/welcome/assets/images/icons/PNG/credits.png": "8eb3c439b19df88fb7643c395bc983b2",
"assets/packages/welcome/assets/images/icons/PNG/facebook.png": "d54e509f31d051140eca9e8d7b34ec40",
"assets/packages/welcome/assets/images/credits/profiles/lars.jpeg": "2f43b1584771754fbde05c3bb1a98c10",
"assets/packages/welcome/assets/images/credits/profiles/null.png": "74c2d1eb37ec4a0b1a5b45edc7e67082",
"assets/packages/welcome/assets/images/credits/profiles/goktugvatandas.jpeg": "e0389311e895d7be5b4a020067e10d9b",
"assets/packages/welcome/assets/images/credits/profiles/evolutionevotv.png": "4f359631bcf8df05aa8926490367b469",
"assets/packages/welcome/assets/images/credits/profiles/fristover.png": "d77e781c46f9030f9fce4905c851f320",
"assets/packages/welcome/assets/images/credits/profiles/x7.jpeg": "0a7fb010e70ddeb807a6b0cd45ed89c1",
"assets/packages/welcome/assets/images/credits/profiles/vanzh.png": "b010c6f5739d6582e4dd0222ceb82d99",
"assets/packages/welcome/assets/images/credits/profiles/funeoz.jpeg": "d522359a4cebc56c1b010d045841842e",
"assets/packages/welcome/assets/images/credits/profiles/aoaowangxiao.jpeg": "9ae0961c56817aa27de43e03a53c5982",
"assets/packages/welcome/assets/images/credits/profiles/faust.png": "85391c85d4fb7379905cd045ab1d5606",
"assets/packages/welcome/assets/images/credits/profiles/noah.jpeg": "c548542b5b181616bd48d4076e664b58",
"assets/packages/welcome/assets/images/credits/profiles/febryardiansyah.jpeg": "ad4d73dd3ffad660e2a37f020e2687d5",
"assets/packages/welcome/assets/images/credits/profiles/hexa.png": "05be54479df969190e021c60bf210e57",
"assets/packages/welcome/assets/images/credits/profiles/nobody.png": "8ac80de1e2063e5db0fdc2f682635a40",
"assets/packages/welcome/assets/images/credits/profiles/bleonard.png": "7a774ad7d57b711273cba62eeefb0b5e",
"assets/packages/welcome/assets/images/credits/profiles/subspace.png": "0951d9906bf56e0c894cdb8a6af132f6",
"assets/packages/welcome/assets/images/credits/profiles/allansrc.jpeg": "af27db872311cc380cadd9f1bce7a443",
"assets/packages/welcome/assets/images/credits/profiles/Seplx.png": "0f93a00592511db7fc73f2fb5166307b",
"assets/packages/welcome/assets/images/credits/profiles/camden.jpeg": "31a9c7ddfb766bf64258ce435c386fc4",
"assets/packages/welcome/assets/images/credits/profiles/haru.jpeg": "8b9b2dc7e5860d2ed1dcbc6caf91e4f8",
"assets/packages/welcome/assets/images/credits/profiles/xeu100.png": "a13f15fdcb81367ba3c5f8aaf4a6d977",
"assets/packages/welcome/assets/images/credits/profiles/horus.png": "0954704c21a5dd4b9e1c1d3002731d93",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text_whiteout.png": "4c4c4c4b3bc16ddf0ce1c093dbffe1cb",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text_drop_shadow.png": "82ef01d759b024043c40ad24407e9d3d",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text.png": "f264be62148b7f8895a8bd261b4ec433",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS-modern.png": "027dab4f9150bb5769a7714cfa725033",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo.png": "02f1c9f097b0a80bf77544d0a382d990",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo_drop_shadow.png": "3ba49cfcd43616510002a9431b90bdb5",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/dahliaOS_logo_whiteout.png": "fc5d033493393879d034a10b273a3325",
"assets/packages/welcome/assets/images/logos/dahliaOS/PNG/logo-white.png": "82a55abdd5529f95c9d7cc31e541692d",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "174c02fc4609e8fc4389f5d21f16a296",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/utopia_wm/fonts/CustomIcons.ttf": "cc73b5bfddd6e04d22b8bdc9fae42b87",
"assets/NOTICES": "b362bfc8e16c10f526f23f713d4ec076",
"icons/Icon-192.png": "8b796818f0e035735378238fc07b5845",
"icons/Icon-512.png": "19ef15ec4cf1762faa56096e0803f57e",
"favicon.png": "353cc04a466aee60dcab137995ed9a09",
"manifest.json": "846faeef084c96fba071c878f4500620",
"version.json": "b6615ffc01e5200a28775ba27eed0bf9",
"main.dart.js": "5a61f1d44b32c5fef9fe21a52b6ca52f",
"index.html": "ea2d85b1ef573c60daca1fc7cb9aaa10",
"/": "ea2d85b1ef573c60daca1fc7cb9aaa10"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
