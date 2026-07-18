# House taste defaults

These `house-default` rules apply only after hard rules, approved requirements/concept/design system, project overrides, and the user taste profile. Record a material exception with rule ID, reason, surface, approving source, and browser-verification requirement.

| ID | Category | Strength | Rule | Allow when |
| --- | --- | --- | --- | --- |
| HT-01 | controls | house-default | Avoid square or nearly square buttons; use deliberate rounded controls. | brutalist, technical, terminal, industrial, or existing brand system |
| HT-02 | headings | house-default | Avoid decorative eyebrow labels that repeat headings. | real status, taxonomy, chronology, or metadata |
| HT-03 | labels | house-default | Avoid small uppercase labels used only to simulate premium design. | meaningful navigation/status taxonomy |
| HT-04 | color | house-default | Avoid generic purple-to-blue SaaS gradients. | approved concept requires it |
| HT-05 | color | house-default | Avoid neon. | approved concept genuinely requires it |
| HT-06 | icons | house-default | Avoid an icon in a colored rounded square before every heading. | semantic product control |
| HT-07 | architecture | house-default | Avoid card-heavy page architecture. | independent repeated entities |
| HT-08 | alignment | house-default | Avoid centering every section. | focused statement, confirmation, or narrow conversion step |
| HT-09 | typography | house-default | Prefer expressive typography to decorative interface clutter. | established product convention |
| HT-10 | density | house-default | Prefer breathing room to visual accumulation outside dense product surfaces. | genuine dense application surface |
| HT-11 | surfaces | house-default | Avoid arbitrary soft shadows, blur, and glass on every surface. | approved design system |
| HT-12 | serif | house-default | Do not use serif as automatic luxury shorthand. | editorial, cultural, fashion, hospitality, or approved brand |
| HT-13 | composition | house-default | Prefer controlled asymmetry over default symmetric SaaS layouts. | product task benefits from symmetry |
| HT-14 | motion | house-default | Do not use scroll-jacking. | never for ordinary navigation |
| HT-15 | imagery | house-default | Treat photography and artifacts as composition, not inserted rectangles. | utility screen without imagery |
| HT-16 | measures | house-default | Do not use one text width for every section. | narrow utility flow |
| HT-17 | containers | house-default | Do not force all content into one identical centered container. | focused utility screen |
| HT-18 | hero | house-default | Avoid default 50/50 text-image heroes. | content genuinely supports it |
| HT-19 | sections | house-default | Do not give all sections identical apparent height. | repeated data rows |
| HT-20 | alignment | house-default | Do not center content merely to appear clean. | focused statement or confirmation |
| HT-21 | grids | house-default | Do not reuse identical three-column grids for unrelated section types. | real repeated independent entities |
| HT-22 | filler | house-default | Do not fill space with decorative cards, arbitrary numbers, or meaningless statistics. | verified, meaningful evidence |
| HT-23 | imagery | house-default | Images must dominate, support, or intentionally interrupt composition. | none |
| HT-24 | marketing | house-default | Marketing pages need one justified compositional shift. | utility application screen |
| HT-25 | desktop | house-default | Use wide desktop space deliberately, not as a narrow mobile-like column. | narrow reading task |

Profile location: `<WEB_STUDIO_AGENT_HOME>/taste/PROFILE.md`. Project override location: `<project-root>/.studio/TASTE_OVERRIDES.md`. Shipped defaults never overwrite either file.
