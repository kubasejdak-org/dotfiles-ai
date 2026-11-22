# Superseding and Amending Examples

A decision that is replaced gets `(superseded by D-NNN)` appended to its title, and the new entry names what it
replaces:

```markdown
## D-017 — Docker Compose for development, Kubernetes for R&D (superseded by D-079)

...

## D-079 — R&D deployment is Docker Compose with a registry image, not Kubernetes manifests

**Date:** 2026.03.14

**Decision:** ... This supersedes the Kubernetes part of D-017; D-006 still holds.
```

A decision that is only partly changed keeps its title, because the rest of it still holds. An inline note marks only
the affected sentence, and the new entry says what it amends:

```markdown
## D-049 — Services reach the database through a fixed IP address

**Date:** 2025.06.02

**Decision:** Services connect to the database at 10.0.0.5 (amended by D-092: a hostname may replace the IP address),
using connection pooling.

## D-092 — Database hostname `db.internal` may be used instead of the fixed IP

**Date:** 2026.02.10

**Decision:** This amends D-049: services may use the hostname `db.internal`. The rest of D-049 still holds.
```

A reader of D-049 sees the original text plus a pointer to what changed; connection pooling is still current, only the
IP part is overridden.
