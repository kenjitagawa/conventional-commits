#!/bin/sh

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")

GITMOJI=$(gum choose ":art:" ":zap:" ":fire:" ":bug:" ":ambulance:" ":sparkles:" ":memo:" ":rocket" ":lipstick:" ":tada:" ":white_check_mark:" ":lock:" ":poop:" )

# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"


# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

MESSAGE="$TYPE$SCOPE: $GITMOJI $SUMMARY"

JIRAISSUE=$(gum input --value "jira-issue: " --placeholder "Jira issue")

# Commit these changes
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION" -m "$JIRAISSUE"
