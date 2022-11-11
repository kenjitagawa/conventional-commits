#!/bin/sh

function gitadd () {
    FILESTOADD=$(ls | gum choose --no-limit)

    gum confirm "Add these files?" && git add $FILESTOADD || exit 1
    # printf '%s\n' "$1" >&2 ## Send message to stderr.
    # exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

gum confirm "Did you make sure to run 'git add' on all the files you want to commit?" && echo "Cool! Continuing..." || \
    (echo "Please run 'git add' on the files you want to commit, then run this script again." && gitadd)


TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")

# GITMOJI="$(gum table < gitmojis.csv -w 12,2 | cut -d ',' -f 1 | gum choose)"

# GITMOJI=$(gum choose ":art:" ":zap:" ":fire:" ":bug:" ":ambulance:" ":sparkles:" ":memo:" ":rocket" ":lipstick:" ":tada:" ":white_check_mark:" ":lock:" ":poop:" )

GITMOJI=$(echo ":art:" ":zap:" ":fire:" ":bug:" ":ambulance:" ":sparkles:" ":memo:" ":rocket" ":lipstick:" ":tada:" ":white_check_mark:" ":lock:" ":poop:" | gum format -t emoji | gum choose  )


# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"


# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

MESSAGE="$TYPE$SCOPE: $GITMOJI $SUMMARY"

JIRAISSUE=$(gum input --placeholder "Jira issue without the brackets.\
            We will add that for you!")

JIRAISSUEFORMATTED="jira-issue: [$JIRAISSUE]"

# Commit these changes
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION" -m "$JIRAISSUEFORMATTED"
# gum confirm "Commit changes?" && echo "$MESSAGE\n$DESCRIPTION\n$JIRAISSUEFORMATTED"
