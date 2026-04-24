# Chef Jenga Game - Refactoring Exercise

This repository contains a composition of Chef cookbooks designed for a Chef Jenga refactoring exercise.
The goal is to practice safe refactoring techniques on a sample application deployment while maintaining functionality.

## Cookbooks

- `base` - A library cookbook providing shared helpers and utilities
- `app` - A cookbook that installs and configures a sample application with a web server
- `jenga` - A server role cookbook that includes the app cookbook

## Game Rules

Chef Jenga is a collaborative team exercise for practicing safe infrastructure refactoring with Chef.

It mirrors physical Jenga:

- All players share a single stack of blocks.
  - Stack - codebase with Chef cookbook(s)
  - Block - a unit of code or functionality (recipe/resource/helper/attribute/etc.).
- Each turn removes one block and adds another on top.
- The stack must remain standing (convergent and functionally identical to initial state) after each turn.
- If the stack falls, the next turn is to repair the stack to the working state, or to revert the changes.

In each turn, there is one player designated as the "driver" who performs the code changes, while the other players are "observers" who can provide suggestions and feedback.

In the end, it is a team exercise where everyone is responsible for the success and learning of the group, rather than an individual competition.

### Core Rule

Every turn must contain actions:

1. Remove one meaningful implementation unit (recipe/resource/helper/attribute/etc.).
2. Add one meaningful replacement unit (recipe/resource/helper/attribute/etc.).
3. Ensure the stack remains convergent and passes the tests.

A turn without all actions above is invalid and will not be counted.

### Turn Mechanics

Each turn includes the following steps:

1. Analyze - What is the change scope and risk? The change must be meaningful, yet small enough to complete quickly.
2. Implement - Remove one block of code and add a replacement block.
3. Converge - Converge the stack to verify it remains standing (use `jenga_converge` command).
4. Verify - Verify the expected behavior remains intact (use `jenga_test` command).
5. Commit - Commit completed change with meaningful message (use `jenga_commit` command).

Driver may repeat implement, converge, and verify steps as needed before final commit. Once the change is done, the driver commits it to mark the turn as complete and ready for facilitator recording and verification.

## Meaningful Change Definition

A change is meaningful when it improves structure, maintainability, or behavior path.

### Examples of meaningful removals

- Remove a hardcoded value.
- Remove duplicate resource blocks.
- Remove inline file/script content.
- Remove complex logic from attributes and recipes.

### Examples of meaningful additions

- Add helper method to encapsulate logic.
- Add loop/iteration to replace duplicates.
- Add template-driven content.

### Invalid/Non-meaningful patterns

- Remove without replacement.
- Add without removal.
- Cosmetic-only edits.
- Multi-feature rewrites that exceed turn scope.
- Reverting the same change in consecutive turns.
- Skipping analyze, verify, or commit steps.

## Collaboration Rule

- One active driver at a time. Other players are observers.
- Observer suggestions are allowed and encouraged.
- Facilitator resolves disputes about scope and validity.
- Facilitator records and verifies completion against the driver's turn commit.
- Team collectively manages risk and learning over winning.
