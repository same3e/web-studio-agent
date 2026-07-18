# PWA

## Decision profile

Use when a web app needs installability and verified offline/device behavior. Baseline: web app plus manifest, service worker, explicit cache/sync policy; validate install, update, offline scope, recovery, storage. Do not use when native capabilities or offline guarantees exceed web constraints. Limitation: browser/device variance.

## Record

Write the selected or rejected profile and its project-specific changes to .studio/TECH_DECISION.md.
