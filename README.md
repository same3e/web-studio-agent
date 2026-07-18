# Web Studio Agent

Four coordinated skills for running a small, fact-based web studio in Codex and Claude Code.

## Workflow

1. `studio-setup` — prepares the studio knowledge base, templates, reference library, and project folders.
2. `add-reference` — analyzes website URLs, screenshots, and images and stores reusable reference notes.
3. `new-site-project` — gathers business facts, selects references, and presents three concepts before implementation.
4. `build-site` — implements only an approved concept, verifies the result, and writes a build report.

The system has approval gates: it does not invent commercial claims and does not start implementation before a concept is approved.

## Install in Codex

Install this public repository as a Codex plugin through the plugin manager. Then use prompts such as:

```text
$studio-setup initialize this folder as a web studio
$add-reference process all new images in inbox
$new-site-project create a landing page for ...
$build-site implement the approved concept
```

## Install in Claude Code

Add the repository as a marketplace and install it for the user account, so it works across projects:

```text
/plugin marketplace add same3e/web-studio-agent
/plugin install web-studio-agent@web-studio-agent --scope user
/reload-plugins
```

Use the namespaced commands:

```text
/web-studio-agent:studio-setup
/web-studio-agent:add-reference
/web-studio-agent:new-site-project
/web-studio-agent:build-site
```

## Recommended order

```text
studio-setup → add-reference → new-site-project → approve a concept → build-site
```

Do not skip the approval step between planning and implementation.

## Repository layout

```text
skills/          The four portable agent skills
knowledge/       Shared studio rules and controlled vocabularies
templates/       Project document templates
.codex-plugin/   Codex plugin manifest
.claude-plugin/  Claude Code plugin and marketplace manifest
```

## Safety and scope

- Use only confirmed business facts in public-facing copy.
- Keep client projects and private assets outside this public repository.
- Review skill instructions before granting broad shell or network permissions.
- The plugin does not provide hosting, client data storage, or external integrations by itself.

## License

MIT. See `LICENSE`.
