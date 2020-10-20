#!/usr/bin/env bash

TEAM_ID="3762014"
for USER in $(cat "github-management/manage-users/users-to-add.txt"); do
  curl --user "fsadykov:${GIT_ADMIN_TOKEN}" -X DELETE "https://api.github.com/teams/${TEAM_ID}/memberships/${USER}" 
  
done
