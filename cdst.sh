#!/bin/bash

# Set the start and end dates
start_date="2023-01-01"
current_date=$(date +%Y-%m-%d)

# Loop through each date
date="$start_date"
while [[ "$date" < "$current_date" ]]; do
  # Exclude November 18-30
  if [[ "$date" < "2023-11-18" || "$date" > "2023-11-30" ]]; then
    # Reduce commits in August
    if [[ "$date" > "2023-07-31" && "$date" < "2023-09-01" ]]; then
      num_commits=$((RANDOM % 2)) # 0 or 1 commit in August
    else
      num_commits=$((1 + RANDOM % 5)) # 1-5 commits other months
    fi

    for ((i=0; i<num_commits; i++)); do
      # Create/modify a file
      echo "Commit on $date" >> activity.txt

      # Add and commit
      git add activity.txt
      export GIT_COMMITTER_DATE="$date 12:30:00"
      export GIT_AUTHOR_DATE="$date 12:30:00"
      git commit -m "Update on $date"
    done
  fi

  # Move to the next day
  date=$(date -I -d "$date + 1 day")
done

# Push the commits
git push origin main
