# ADR 0002: Modular AI Standards and Automated Delivery

**Status**: Accepted  
**Date**: 2026-02-04

## Context

Initially, the project relied on manual installation instructions and a fragmented set of global skills. This led to inconsistent environments and high friction for new contributors.

## Decision

We have implemented three core architectural pillars:

1. **Hybrid Model**: Separation of **Global Mega-Roles** (Architect, Ops, Designer) from **Local Plugin Skills** (Python, Electron, etc.).
2. **Automated Setup**: Implementation of an idempotent `setup.sh` script to manage standard synchronization.
3. **Strict Visual Quality**: Enforcement of **ATX-style headings** and **Shields.io badges** to ensure a premium, consistent documentation brand.
4. **Automatic Quality Gates**: Use of GitHub Actions with `markdownlint` to prevent stylistic drift.

## Consequences

* **Zero-Debt Onboarding**: New users can install the standards in seconds using the setup script.
* **Visual Hardening**: All generated reports and templates follow a unified aesthetic.
* **Reduced Context Friction**: Agents only load the skills relevant to the current workspace, while keeping core roles always available.
