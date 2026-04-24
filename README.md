# Chef Jenga

Chef Jenga is a collaborative team exercise for practicing safe infrastructure refactoring with Chef.

It mirrors physical Jenga:
- All players share a single stack of blocks.
  - Stack - codebase with Chef cookbook(s)
  - Block - a unit of code or functionality (recipe/resource/helper/attribute/etc.).
- Each turn removes one block and adds another on top.
- The stack must remain standing (convergent and functionally identical to initial state) after each turn.
- If the stack falls, the next turn is to repair the stack to the working state, or to revert the changes.

Additionally, the game emphasizes:
- Meaningful change: Each turn must include a meaningful removal and a meaningful addition.
- Traditional workflow: Each turn follows analyze -> implement -> verify -> commit, repeating verify/implement as needed.
- Multi-cookbook progression: Implementation uses two complementary cookbooks (base library and app) that demonstrate real refactoring scenarios.
- Environment consistency: Sessions run in the repository's existing devcontainer environment.
- Validation: Driver may run validation during the turn, and each turn must end with a final convergence check.
- Facilitation: A facilitator manages the session, enforces rules, and captures outcomes.
- Turn completion commit: Driver commits a completed turn with a meaningful message so facilitator can record and verify it.
- Team accountability: Players must explain their change rationale and risk before execution, and the team must collectively manage risk.
- Learning focus: The game is designed to encourage learning and discussion about refactoring techniques, trade-offs, and best practices in Chef.

## Pre-requisites

- Linux (Host/VM/WSL2) environment with Docker
- Git
- VSCode with Dev Containers extension

## Quick Start

Clone the repository and switch into the project directory:

```bash
git clone https://github.com/plechenko-coupa/ChefJenga
cd ChefJenga
```

Run the `start.sh` script to initialize the workspace and open the project in a dev container:

```bash
./start.sh
```

This will set up the workspace and open it in a VSCode dev container.

VSCode will install the Live Share extension and prompt you to sign in to enable collaboration features. Once done, you can start a Live Share session and invite your teammates to join.

Happy Jenga-ing!
