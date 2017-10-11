# IBM Cloud University 2017
## Session: BLUE031
## Step-by-Step Instructions

### Preparation

1. Logon to your Lab machine
2. Open a browser
3. As you are reading this, you should already be here, but if you printed this instructions, point your browser to `https://github.com/ICU2017Schematics/ICU2017Lab` or simply click this <a href="https://github.com/ICU2017Schematics/ICU2017Lab">link</a>.
4. Click on ![supplies][supplies.zip]
4. Open a new browser tab (or window) and point it to "https://console.bluemix.net", click the "Login" button and provide the credentials.
5. Once logged in, switch to Region _US South_, Organization _ICU2017_ and Space _dev_ like shown ![regionselector][images/regionselector.png?raw=true]
6. Open the main navigation on the leftmost side ![mainmenu][images/mainmenu.png?raw=true]
7. Click on **Schematics** in that menu

---
### Create a Schematics Environment

1. In the _Schematics_ browser window, click on _Environments_. You see the list of environments if there are any.
2. Click on _Create Environment_ on the right upper side of the window
3. Enter the following git URL in the _Source Control URL_ entry field:
`https://github.com/ICU2017Schematics/ICU2017Lab`
Note that  as soon as you leave the entry field, the variables that are defined in your `.tf`files in the repository are being pre-populated in the _Variables_ section of your environment. However, there are some empty fields that we now need to fill.
4. Add the `ibm_bmx_api_key` we provided and make it invisible.
5. Add the `ibm_sl_api_key` as well and also make it invisible.
6. Add the `ibm_sl_username`.
7. Add the `myOrg` variable, set it to `ICU2017`.
8. Add the `mySpace`vairable, set it to `dev`.
9. The `public_vlan_id` and `private_vlan_id` shouldn't be empty and are used for the paid Kubernetes cluster configuration, so for now, please set it to `0`.
10. Provide a meaningful name as the _Environment Name_ making it unique with your initials or something that makes it unique for this Hands-on.
11. You can provide a meaningful description like some parts of the overall description
12. Hit the **Create** button on the top right of the page and you will get placed in the _Environment Details_ page where you can see all the parameters and also have an activity log in the right column of the page.
This now gives you the ability to run Terraform actions like _plan_ and _apply_ as well as _destroy_.

---
### Find your way in Schematics
1. The left navigation allows you to see different portions related to the currently opened environment, like _Details_, _Configuration Readme_, _Variables_ and _Resources_. Let's take a look at them.
2. As you are already in the _Details_ section, click on _Configuration Readme_. It loads and renders the README.md file from the git repository.
3. Click on _Variables_. This shows you all the defined Terraform variables that are defined and passed over to Terraform. Note that you can make sensitive values invisible. Invisible variables are not editable for security reasons. You can only delete them and re-create.
4. Click on _Resources_. This view shows a list of resouces that were created by this environment. For newly created _Schematics environments_, this view is empty until you successfully ran an _Apply_ activity.
5. If you want to go back to the environment list, please use the breadcrumb trail on the top of the center column. Clicking on _Environments_ will get you to the environment list page, clicking on _Schematics_ will get you to the _Getting Started_ page.
6. Once you are on the _Getting Started_ page, the leftmost navigation changes. Click on _Templates_. This shows some Terraform configurations that you can use to create _Schematics_ environments. The templates also provide a github link so that you can fork and enhance them to fit your needs.


---
### Running Terraform Actions

1. Now go back to the _Environments_ page and click your environment. This should get to to the _Details_ page for this environment.
2. A best-practice for Terraform is to first run a _plan_ action and check if the proposed result is what you expect. So, for now, please hit the **Plan** button on the right.
3. Once you hit the **Plan** button, a new activity is created in the activity log on the right portion of the page.
4. Wait a few seconds and hit the _Refresh_ link on the activity pane.
5. Once it finishes, you see a _View Log_ button appear in the activity pane. Click the _View Log_ button.
6. Inspect the log file that shows up.
7. If you are happy and you should be happy if the _plan_ says `Plan: 9 to create, 0 to change, 0 to destroy`
8. Hit **Apply** and sit back. After a few minutes you should be able to access you application.
9. After the apply finished, check the logs again to figure out the IP address of the Kubernetes cluster.
10. point your browser to https://<ip>:30000.
