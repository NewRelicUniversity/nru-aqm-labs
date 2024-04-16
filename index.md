# Prerequisites

To complete this lab, you will need: 
- A personal New Relic account. If you don’t have one, you may sign up for a free account here: [https://newrelic.com/signup](https://newrelic.com/signup). 
- A personal [Github account](https://github.com).

# Start the lab environment and add your license key

## Step 1
Log into your Github account and navigate to [https://github.com/codespaces](https://github.com/codespaces). Click the New codespace button in the upper right corner.

## Step 2
On the Create a new codespace page, click _Select a repository_ and search for **NewRelicUniversity/nru-aqm-lab**. Click the _Create codespace_ button at the bottom of the page.

## Step 3
In another browser tab, log into your New Relic account. Copy your INGEST - LICENSE key from the [API keys](https://one.newrelic.com/launcher/api-keys-ui.api-keys-launcher) page.

## Step 4
Back in your codespace, select the **newrelic-infra.yml** tab and replace the YOUR_LICENSE_KEY placeholder with the license key you copied in Step 3.

## Step 5
Wait for the terminal window to finish running the startup script, then execute the command `./start.sh` to start the Infrastructure agent. Within a few minutes, you should see Infrastructure log messages on the Logs page of your New Relic account.

---

# _Lab:_ Using tags to organize entities

Ref: [https://docs.newrelic.com/docs/new-relic-solutions/new-relic-one/core-concepts/use-tags-help-organize-find-your-data/](https://docs.newrelic.com/docs/new-relic-solutions/new-relic-one/core-concepts/use-tags-help-organize-find-your-data/)

## Step 1
Select the `nru-aqm-lab` host from the list of entities reporting to your account.

## Step 2
Select _Tags_ at the top of the screen. Add one or more tags in the format _key: value_ (for example, _Environment: Training_). You will use one of these tag values in the next lab to specify that an alert condition should monitor this host.

---

# _Lab:_ Using tags in alert conditions

## Step 1
From New Relic’s main menu, select _Alerts & AI_, then  _Create alert condition_ from the _Welcome_ page. (If you already have alert conditions in your account, select _Alerts & AI > Alert Conditions > + New alert condition_.)

## Step 2
Select _Write your own query_. Write a query to return the maximum percentage of CPU usage from each host matching one of the tag values you added in the previous lab.

## Step 3
On the next screen, set a static threshold to open a critical incident when the query returns a value above 50 (percent) for at least 3 minutes. You may optionally add a second threshold to open a warning incident when the query returns a value above 25 for at least 2 minutes.

## Step 4
On the next screen, give your alert condition a clear name to describe what’s wrong when an incident occurs, for example: “Training environment host CPU usage > 50 percent”. Add the alert condition to an existing alert policy, or create a new one.

## Step 5
Click the _Save condition_ button, but don’t set up notifications yet (click _Cancel_ to close the Workflow page).

---

# _Lab:_ Tagging alert conditions and using custom incident descriptions

## Step 1
From New Relic’s _Alert Conditions_ page, select the condition you just created.

## Step 2
Select _Tags_ at the top of the screen. Add one or more tags in the format _key: value_ (for example, _Lab: AQM_). You will use one of these tag values in the next lab to specify that a notification workflow should apply to this condition.

## Step 3
Scroll down to _Additional details_ and click the _Edit_ button. In the _Send a custom incident description_ field, enter a description containing some of the tags you have created, for example: 

<!-- {% raw %} -->
{{ tag.hostName }} is in the {{ tag.Environment }} environment, and is used for the {{ tag.Lab }} lab.
<!-- {% endraw %} -->

For more information, please see [https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/advanced-alerts/advanced-techniques/alert-custom-incident-descriptions/](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/advanced-alerts/advanced-techniques/alert-custom-incident-descriptions/).

## Step 4
Click the _Save condition_ button to save your changes.

---

# _Lab:_ Advanced notification options

## Step 1
From New Relic’s _Alerts & AI_ menu, select _Workflows_, then  _Create your first workflow_ from the _Welcome_ page. (If you already have workflows in your account, select _Workflows > + Add a workflow_.)

## Step 2
Give your workflow a name, then use the _Filter data_ section to specify one of the tags you added to your alert condition in the previous lab. Any issues created by alert conditions with the tag value you select will be processed by this workflow.

## Step 3
If you have a paid New Relic account, click the _Additional settings_ button and enable the _Enrich your data_ option. Enter a name for your query and an NRQL query, such as `SELECT max(cpuPercent) FROM SystemSample FACET hostname SINCE 1 hour ago TIMESERIES`. The result of this query will be included with the alert notification.

## Step 4
In the _Notify_ section, select _Email_ and create a new destination for your email address (or select an existing destination if you have already created one). Save the destination, then click _Activate workflow_.

---

# _Lab:_ Testing your alert condition and workflow

## Step 1
Back in your codespace, enter the following command in the terminal: `stress-ng --cpu 0 -l 75 -t 10m &`

## Step 2
Select the `nru-aqm-lab` host in New Relic and observe the increased CPU usage. Wait several minutes for your alert condition to be violated.

## Step 3
You should receive an email notification at the destination you configured. Notice that the email contains the result of the NRQL query you added to your workflow, as well as the custom incident description you added to your alert condition.

---

# NRQL Alerts Quiz

[https://newrelicuniversity.github.io/alerts-quiz](https://newrelicuniversity.github.io/alerts-quiz)

_Note:_ To ensure that the New Relic Browser agent is reporting correctly, right-click on the page and select _Inspect_, then select the _Console_ tab. If you see any errors other than a 404 for a missing `favicon.ico`, you should disable any ad blockers or privacy extensions, then reload the page. The quiz will work without the Browser agent, but your answers will not be reported to the New Relic dashboard.

After answering the last question, please wait a moment before closing your browser to allow the agent to send your answers to New Relic.

## Additional resources
- [Streaming alerts: key terms and concepts](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/advanced-alerts/understand-technical-concepts/streaming-alerts-key-terms-concepts/)
- [Choose your aggregation method](https://docs.newrelic.com/docs/alerts-applied-intelligence/new-relic-alerts/get-started/choose-your-aggregation-method/)

---

# _Lab:_ Using Terraform to create an alert condition

## Step 1
In your New Relic account, copy a USER key from the [API keys](https://one.newrelic.com/launcher/api-keys-ui.api-keys-launcher) page. If there are no USER keys, click the _Create a key_ button in the upper right to create one, then copy it.

## Step 2
In your codespace, select the **variables.tf** tab and replace the api_key XXXXXX placeholder with the value you copied in Step 1.

## Step 3
Back in New Relic, [locate your account ID](https://docs.newrelic.com/docs/accounts/accounts-billing/account-structure/account-id/) and copy it.

## Step 4
In your codespace, select the **variables.tf** tab and replace the account_id XXXXXX placeholder with the value you copied in Step 3.

## Step 5
If your account is based in the EU, change the default region in **variables.tf** to **EU**.

## Step 6
Initialize Terraform by entering the following command in the terminal: `terraform init`. You'll receive a success message when Terraform finishes installing and registering the New Relic provider.

## Step 7
From New Relic’s _Alerts & AI > Alert Conditions_ page, select the alert condition you created earlier. Click the _</> View as code_ button in the upper right, then select _Terraform_. Finally, click _Copy to clipboard_. Click the _X_ in the upper right to close the _Code preview_ panel.

## Step 8
Go back to the list of alert conditions. Click the ellipsis (...) button to the right of the alert condition you just copied and select _Delete_. Confirm that you wish to delete the condition.

## Step 9
In your codespace, select the **main.tf** file. Position the cursor at the end of the file and paste the Terraform code you copied in Step 7.

## Step 10
Enter the following command in the terminal to preview the changes: `terraform plan`

## Step 11
To apply the changes, enter the following command in the terminal: `terraform apply`

## Step 12
Go back to the list of alert conditions in your New Relic account and reload the page. Confirm that the alert condition you deleted has been re-created.

## Additional resources
- [Getting started with New Relic and Terraform](https://docs.newrelic.com/docs/more-integrations/terraform/terraform-intro/)
- [New Relic Terraform provider documentation](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs)

---

# _Lab:_ Using the NerdGraph Explorer

[https://docs.newrelic.com/docs/apis/nerdgraph/get-started/nerdgraph-explorer/](https://docs.newrelic.com/docs/apis/nerdgraph/get-started/nerdgraph-explorer/)

## Additional resources
- [List of NerdGraph tutorials](https://docs.newrelic.com/docs/apis/nerdgraph/get-started/introduction-new-relic-nerdgraph/#tutorials)
- [Change tracking documentation](https://docs.newrelic.com/docs/change-tracking/change-tracking-introduction/)
