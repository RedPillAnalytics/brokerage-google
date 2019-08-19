# Create the Employee view

The `HR` table in BigQuery has not yet been designed in our Looker model. We'll reverse engineer the `HR` table by clicking **Add Files...** and then selecting **Create View from Table**, and then selecting the `HR` table. Then click the **Create Views** button. We want to call this view `employee` but the default name is `HR`, which is the name of the table in the database schema. Click the gearbox icon next to the `hr` view on the left-hand side of the UI, and choose **Rename**, and type `employee`.

Looker does a really good job of pre-creating the LookML content for the table, but we have several customizations we want to make to it. Feel free to customize the markup content, or simply replace the contents of the view using the text below:

```yaml
view: employee {
  sql_table_name: ORACLE_JUMP.HR ;;

  dimension: source_expired {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED = 'true' ;;
  }

  dimension: replication_id {
    type: string
    hidden: yes
    sql: ${TABLE}._FIVETRAN_ID ;;
  }

  dimension: replication_date {
    type: date_time
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
  }

  dimension: branch {
    type: string
    sql: ${TABLE}.BRANCH ;;
  }

  dimension: employee_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.EMPLOYEE_ID ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${middle_name} || '. ' || ${last_name};;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: job_code {
    type: number
    sql: ${TABLE}.JOB_CODE ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: manager_id {
    type: number
    sql: ${TABLE}.MANAGER_ID ;;
  }

  dimension: middle_name {
    type: string
    sql: ${TABLE}.MIDDLE_NAME ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.OFFICE ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.PHONE ;;
  }

  measure: count {
    type: count
    drill_fields: [full_name]
  }
}
```
Once the text has been pasted in, click the **Save** button on the right, and then click the **Validate LookML** button on the left. You should see the message *No LookML Issues* next to a green check box.

# Add the Manager view

Our model uses the `HR` table to play two roles: both the `employee` role and the `manager` role. We need to create a new view for `manager`, but we don't want to recreate the table completely. Here we will use the *extend* keyword to create an alias for `manager` based on the `employee` view.

Click on the **Add Files...** button on the left and then select **Create View**, and call it `manager`. Looker will pre-seed the contents of the new view with a sample template of LookML. Replace the LookML in the file with the contents below:

```yaml
include: "employee.view.lkml"

view: manager {
  extends: [employee]
}
```
Click the **Save** button on the right, and then click the **Validate LookML** button on the left. You should see the message *No LookML Issues* next to a green check box.

# New HR Explore

Our two new views exist in LookML and are valid, but now we want to make them available in Looker Explores. The first thing we do is *include* these two view files in our `brokerage` model. To do this, click `brokerage` under **Models** and add the following lines below, just after the the final *include* line:

```yaml
include: "employee.view.lkml"
include: "manager.view.lkml"
```

Much like doing an *import* in Java or other languages, this makes the contents of those views available to the `brokerage` model. Click the **Save** button on the right, and then click the **Validate LookML** button on the left. You should see the message *No LookML Issues* next to a green check box.

These views will not be available to a user in the **Explore** menu, because we haven't included them in a Looker Explore yet. Click `brokerage` under **Models**, and you will see the current Explore already defined called `trade`.

We could easily modify `trade` to include these two new views, but we might want to make our LookML model *granular*, meaning that Explores are designed to include subsets of the total content available. We want a new Explore called `hr` that includes everything from the `trade` Explore, but also contains the two new views.

To do this, create the new explore using the *extends* keyword by either writing the LookML yourself, or paste the following LookML in at the very end of the `brokerage` model:

```yaml
explore: hr {
  view_name: trade
  extends: [trade]
  join: employee {
    relationship: many_to_one
    type: inner
    sql_on: ${trade.executor_id} = ${employee.employee_id} ;;
  }
  join: manager {
    relationship: many_to_one
    type: inner
    sql_on: ${employee.manager_id} = ${manager.employee_id} ;;
  }
}
```

Click the **Save** button on the right, and then click the **Validate LookML** button on the left. You should see the message *No LookML Issues* next to a green check box.

We have made all the LookML changes necessary in our personal Git branch, and though we haven't yet *committed* those changes, they are already available to us in the Explore menu while in Development mode. Refresh your browser, and we should see **HR** as an option now in the **Explore** menu. This is a handy way to test LookML changes without having to actually deploy then to the Production branch.

To commit these changes, click the `Commit Changes` button on the left side of the UI. Provide an SCM message, and then click **Commit**.
