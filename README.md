# Chef Jenga

Chef Jenga is a collaborative team exercise for practicing safe infrastructure refactoring with Chef.

It mirrors physical Jenga:
- All players share a single stack of blocks.
  * Stack - codebase with Chef cookbook(s)
  * Block - a unit of code or functionality (recipe/resource/helper/attribute/etc.).
- Each turn removes one block and adds another on top.
- The stack must remain standing (convergent and functionally identical to initial state) after each turn.

Additionally, the game emphasizes:
- Meaningful change: Each turn must include a meaningful removal and a meaningful addition.
- Traditional workflow: Each turn follows analyze -> implement -> verify -> commit, repeating verify/implement as needed.
- Time-boxed turns: Each turn is strictly limited to 3 minutes.
- Multi-level progression: Implementation includes several cookbooks for different levels.
- Environment consistency: Sessions run in the repository's existing devcontainer environment.
- Validation: Driver may run validation during the turn, and each turn must end with a final convergence check.
- Facilitation: A facilitator manages the session, enforces rules, and captures outcomes.
- Turn completion commit: Driver commits a completed turn with a meaningful message so facilitator can record and verify it.
- Team accountability: Players must explain their change rationale and risk before execution, and the team must collectively manage risk.

Refer to the [Game Rules](docs/game_rules.md) for detailed rules and mechanics.

## Documentation

For complete guidance, use the docs in this order:
1. [Documentation Index](docs/README.md)
2. [Game Rules](docs/game_rules.md)

Additional guides:
- [Scenario](docs/scenario.md)
- [Facilitator Guide](docs/facilitator_guide.md)
- [Player Guide](docs/player_guide.md)
- [Bash Implementation](docs/bash_implementation.md)

## Recommended Session Agenda

- 10 minutes: intro, connectivity test, and Q&A about the game.
- 15 minutes: round 1 (simple, familiarization), then 5 minutes review.
- 15 minutes: round 2 (added complexity), then 5 minutes review.
- 15 minutes: round 3 (more complexity), then 5 minutes review.
- 15 minutes: round 4 (multi-cookbook), then 15 minutes debrief.
