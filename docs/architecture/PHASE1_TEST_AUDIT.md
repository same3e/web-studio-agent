# Phase 1 behavioral-test audit

Audit date: 2026-07-18. Before Phase 1.1, [`scripts/test_phase1_behavioral.ps1`](../../scripts/test_phase1_behavioral.ps1) loaded repository text and checked substrings or file presence only. It did not create a project workspace, invoke preflight, route a specialist, start a runtime, or inspect a browser.

| Fixture | Input state described | Command / assertion | Classification | Resulting limitation |
| --- | --- | --- | --- | --- |
| A — dental landing | Missing medical facts/photos and unavailable endpoint/messenger | `test_phase1_behavioral.ps1` checks policy text including placeholders and browser-QA wording | static content assertion | Does not test a form, placeholder, or browser runtime |
| B — OSS developer tool | References supplied; URL/stars/users/logos absent; concept approved | Same script checks discovery, concepts, ledger, and technical-template strings | static content assertion | Does not route a real project or validate a CTA |
| C — missing approval | Conversation approval but absent `APPROVED_CONCEPT.md` | Checks preflight template and skill wording only | static content assertion | Did not execute preflight or block writes |
| D — concept render provenance | Generated concept image, no runtime | Checks provenance wording only | static content assertion | Did not validate ledger/report classification |
| E — static vs browser | CSS inspected, no browser run | Checks browser-contract wording only | static content assertion | Did not execute a browser or reject an invalid report |

Phase 1.1 adds [`scripts/test_phase1_runtime.ps1`](../../scripts/test_phase1_runtime.ps1), which uses an ignored disposable workspace and invokes the actual preflight, approved-record initializer, specialist resolver, and provenance/content validator. It is a runtime behavioral and state-machine test for project records; it is not application-browser QA.

The original A–E script remains valuable as a structural guard against accidental removal of policy text, but it must not be presented as full runtime behavioral coverage.

## Phase 1.1 executed result

`pwsh -File scripts/test_phase1_runtime.ps1` passed on 2026-07-18. It blocked Case A for the named missing approval record; blocked Case B for missing derived records, then used [`Initialize-ApprovedProjectRecords.ps1`](../../scripts/Initialize-ApprovedProjectRecords.ps1) to add only absent templates and passed preflight; and passed Case C with `.studio/reports/specialist-plan.md`.

The same run rejected a browser-verification claim with no screenshot ledger entry and rejected unsupported GitHub/stars/form/messenger/policy entries. It then accepted an explicitly visible unavailable placeholder and a complete browser-screenshot provenance row. These are record-validator runtime tests, not end-user browser tests.
