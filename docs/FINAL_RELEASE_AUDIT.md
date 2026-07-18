# Final release audit

## Final architecture

The release tree exposes exactly two user-facing skills: `product-studio` and `add-reference`. Product-studio owns discovery, scope, technical recommendation, concepts, explicit approval, implementation, and verification. Add-reference owns project-local URL/screenshot/screen/flow analysis and indexes.

## Knowledge and state

`knowledge/KNOWLEDGE_INDEX.md` routes 121 modular methodology files by task, project state, product type, and risk. Mutable project information belongs in `.studio/`; templates cover state, discovery, roles, flows, scope, references, concept, approval, copy, system, plan, criteria, and reports.

## State machine

`uninitialized → discovery → requirements → technical-decision → references-needed → concepts → awaiting-approval → approved → implementation → verification → complete`. Explicit approval is required before implementation; approval updates `APPROVED_CONCEPT.md` and permits automatic continuation.

## Validation results

- Migration validator: passed; two active skills, 121 modular knowledge files, project-local initialization/preservation fixture, packaging, examples, routing, factual/no-copy, and workflow coverage checked.
- Codex plugin validator: passed.
- Skill validators: passed for both active skills.
- Existing Noma sample: TypeScript, ESLint, and production build passed; build required execution outside sandbox because sandboxed Next.js child process spawning returned `EPERM`.
- Claude marketplace JSON is locally schema-checked by migration validation. `claude plugin validate .` and user-scope installation were not run because a Claude CLI/session is not available in this environment.

## Legacy migration

Legacy skills, flat knowledge/templates, old public-release copy, and historical project material were removed from the release tree only after validation and are preserved under `backups/`. They are ignored by Git and must not be committed or published.

## Known limitations and manual actions

1. Run `claude plugin validate .` locally, add the marketplace at user scope, install `web-studio-agent@web-studio-agent`, run `/reload-plugins`, and confirm `/web-studio-agent:product-studio` and `/web-studio-agent:add-reference` appear.
2. Test the Codex local-plugin installation through its plugin manager and confirm both skills load in a new thread; no global installation was performed here.
3. Review or remove the historical `backups/` directory before any public GitHub commit. It is intentionally excluded from the release but contains non-release historical material.
4. Obtain explicit approval before pushing, publishing, or creating a public release.
