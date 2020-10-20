from github import Github
import os
import json
import logging
import sys

logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)

organization_name = "fuchicorp"
g = Github(os.environ.get("GIT_TOKEN"))
organization = g.get_organization(organization_name)


root_access_teams = ["devops", "bastion_root"]
non_root_access_teams = []
for team in organization.get_teams():
    if team.name.lower() not in root_access_teams:
        non_root_access_teams.append(team.name.lower())

bastion_access = {
    "root_access" : [],
    "non_root_access" : []
}


def templetize_user_data(team_list:list, team_object:object):
    user_list = []

    ## Checking for user list
    if team_object.name.lower() in team_list:

        ## Iterating list of user
        logging.info(f"####### Getting all members from team <{team_object.name}>")
        member_items = organization.get_team(team_object.id).get_members()
        for user in member_items:
            

            ## templetizing the user data
            user_data = {"username" : user.login, "ssh-keys" : [],
            "comment" : f"<{user.name}>, <{user.email}>, <{user.company}>"}

            ## if the user has ssh keys
            if user.get_keys().totalCount:

                ## Checking file exists if yes then delete
                if os.path.isfile(f'{user_data["username"]}.key'):
                    os.remove(f'{user_data["username"]}.key')

                ## Iterating list of users keys
                key_items = user.get_keys()
                for key in key_items:

                    ## Adding list of keys to user data
                    user_data['ssh-keys'].append(key.key)

                    ## Createing the keys for the users
                    with open(f'{user_data["username"]}.key', 'a') as f:
                        f.write("%s\n" % key.key)

                ## Adding usert to total list
                if user_data not in bastion_access["root_access"]:
                    user_list.append(user_data)
            else:
                logging.warning(f"User <{user.login}> does not have ssh key uploaded on github.")

    ## Returing list of users to
    return user_list

if not os.geteuid() == 0:
    sys.exit("\nOnly root can run this script\n")

team_items = organization.get_teams()
for team in team_items:

    # Getting root members
    root_members = templetize_user_data(root_access_teams, team)
    if root_members:
        for user in root_members:
            bastion_access["root_access"].append(user)
    non_root_members = templetize_user_data(non_root_access_teams, team)

    for user in non_root_members:
        if user not in bastion_access["root_access"]:
            bastion_access["non_root_access"].append(user)

for user in bastion_access['non_root_access']:
    for root_user in bastion_access['root_access']:
        if user['username'] == root_user['username']:
            bastion_access['non_root_access'].remove(user)


for user in bastion_access['non_root_access']:
    # print(f"""###### {user["username"]} '{user["comment"]}' {user["username"]}.key """)
    os.system(f"""sudo sh user_add.sh {user["username"]} '{user["comment"]}' {user["username"]}.key""")


for user in bastion_access["root_access"]:
    # print(f"""###### {user["username"]} '{user["comment"]}' {user["username"]}.key --admin""")
    os.system(f"""sudo sh user_add.sh {user["username"]} '{user["comment"]}' {user["username"]}.key --admin""")





with open("output.json", "w") as file:
    json.dump(bastion_access, file, indent=2)
