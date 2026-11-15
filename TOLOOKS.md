# ToLooks

Exploratory scratchpad for backlog ideas, investigative spikes, architectural inquiries, and future refactors.

---

## Active ToLooks

- [ ] **1. Fix Untrusted Tap Error in `update.yml` (`dart-lang/dart`)**
  - **Idea**: Trust the `dart-lang/dart` tap (or pass `--formula`/configure `brew trust`) in `.github/workflows/update.yml` so automated formula updates succeed.
  - **Context**: In [run #43630914272](https://github.com/TarasMazepa/homebrew-stax/actions/runs/43630914272) (2026-11-14, `workflow_dispatch` on `main`), Homebrew refused to load `dart-lang/dart/dart@3.14.0` with `Refusing to load formula dart-lang/dart/dart@3.14.0 from untrusted tap dart-lang/dart. Run brew trust --formula dart-lang/dart/dart@3.14.0 or brew trust dart-lang/dart to trust it.`
  - **Investigation**:
    - [ ] Inspect `.github/workflows/update.yml` where `dart-lang/dart` is tapped/used.
    - [ ] Add `brew trust dart-lang/dart` before invoking formula commands and re-run `update.yml`.

---

## Resolved Architectural Decisions

*(No resolved architectural decisions recorded yet.)*

---

## Related Documentation

- [AGENTS.md](AGENTS.md) — Agent guidelines and ToLooks rules.
- [docs/seeded/tolooks/README.md](docs/seeded/tolooks/README.md) — ToLooks concept and lifecycle guide.
