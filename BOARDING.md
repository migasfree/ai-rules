# 🚀 Onboarding: Welcome to the Migasfree Community

Welcome! This repository, `ai-rules`, is the heartbeat of our AI-assisted development process. It defines the **Standardized Specifications** that ensure every developer, analyst, and writer in the Migasfree community works in harmony.

## 🌟 Why Standardized Prompts?

In a distributed community like ours, consistency is key. By using this repository, you ensure that:

1. **AI Personas are Consistent**: A "Python Developer" means the same thing to your AI assistant as it does to ours.
2. **Workflows are Automated**: We share the same scripts for auditing, committing, and generating code.
3. **Quality is Enforced**: specialized roles (like Security Engineer) automatically check your work against our specific best practices.

## 🛠️ Getting Started

### 1. Prerequisite: Antigravity

Ensure you have the Antigravity AI agent installed and configured.

### 2. Install the Standards

We recommend a **Global Installation** so your AI assistant is "Migasfree-aware" across all your projects.

```bash
# copy the standardized prompt templates
mkdir -p ~/.gemini/antigravity/templates/
cp -r ./templates/* ~/.gemini/antigravity/templates/

# copy the automation workflows
mkdir -p ~/.gemini/antigravity/global_workflows/
cp ./workflows/*.md ~/.gemini/antigravity/global_workflows/

# copy the role definitions (skills)
mkdir -p ~/.gemini/antigravity/global_skills/
cp -r ./skills/* ~/.gemini/antigravity/global_skills/
```

### 3. Verification

Run the following command in any project to verify your installation:

```bash
/skill_list
```

You should see a list of Migasfree roles (e.g., `migasfree_python_developer`, `migasfree_packaging_specialist`).

## 🎭 Your Role in the Community

Depending on your contribution, you should activate different "Skills" for your session.

| If you are... | Activate this Skill | Focus |
| :--- | :--- | :--- |
| **Writing Code** | `Python Developer` | Code style, testing, mTLS patterns |
| **Packaging** | `Packaging Specialist` | `stdeb`, RPM specs, Windows builds |
| **Designing** | `Systems Analyst` | Architecture, data flow, integration |
| **Auditing** | `Security Engineer` | Vulnerability checks, credential safety |
| **Documenting** | `Technical Writer` | Diátaxis framework, user guides |

### How to Switch Roles

You can enable/disable skills dynamically:

```prompt
/skill_on technical_writer
/skill_off python_developer
```

## 🤝 Contribution Guidelines

1. **Always use the `/commit` workflow**: This ensures your commit messages follow our Conventional Commits standard.
2. **Run an Audit before PR**: Use `/audit_report` to self-check your work against our quality gates.
3. **Improve the Standards**: If you find a prompt that can be improved, submit a PR to *this* repository!

Happy Hacking!
The Migasfree Team
