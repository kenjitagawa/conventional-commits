#!/bin/sh

function showfiles() {

    (echo "Adding these files:")
    for file in $1; do
        (echo "\t * $file ✅ \n")
    done

    gum spin --spinner dot --title "One second..." -- sleep 2
    clear
}

function gitadd () {
    (echo 'Here are your changed files: :sparkles: ' | gum format -t emoji)
    FILESTOADD=$(git diff --name-only | gum choose --no-limit)

    gum confirm "Add these files?" && (git add $FILESTOADD | showfiles $FILESTOADD) || exit 1


    # printf '%s\n' "$1" >&2 ## Send message to stderr.
    # exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

gum confirm "Did you make sure to run 'git add' on all the files you want to commit?" && \
     (echo "Cool! Continuing... :rocket:" | gum format -t emoji) || \
    (echo "Let's add some files then... :rocket:" | gum format -t emoji && gitadd)


TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")

SCOPE=$(gum input --placeholder "scope")

GITMOJI="$(gum table < gitmojis.csv -w 2,20 | cut -d ',' -f 2 | gum choose)"

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

gum confirm "Push changes?" && git push || exit 1
