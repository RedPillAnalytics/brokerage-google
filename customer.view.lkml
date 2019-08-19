view: customer {
  sql_table_name: (select *,
                          rank() over (partition by customer_id order by action_ts) customer_rank
                   from brokerage.customer
                   ) ;;

  dimension: customer_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.CUSTOMER_ID ;;
  }
  dimension: customer_rank {
    type:  number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_RANK;;
  }

  dimension: action_timestsame {
    type: date_time
    sql: ${TABLE}.ACTION_TS ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.ACCOUNT_NAME ;;
  }

  dimension: account_tax_status {
    type: string
    sql:CASE ${TABLE}.ACCOUNT_TAX_STATUS
          WHEN 2 then 'Charity'
          WHEN 0 then 'Exempt'
          ELSE 'Non-exempt'
          END;;
  }

  dimension: action_type {
    type: string
    sql: ${TABLE}.ACTION_TYPE ;;
  }

  dimension: address_line1 {
    type: string
    sql: ${TABLE}.ADLINE1 ;;
  }

  dimension: address_line2 {
    type: string
    sql: ${TABLE}.ADLINE2 ;;
  }

  dimension: broker_id {
    type: number
    sql: ${TABLE}.BROKER_ID ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: customer_tax_id {
    type: string
    sql: ${TABLE}.CUST_TAX_ID ;;
  }

  dimension: date_of_birth {
    type: string
    sql: ${TABLE}.DOB ;;
  }

  dimension: email1 {
    type: string
    sql: ${TABLE}.EMAIL1 ;;
  }

  dimension: email2 {
    type: string
    sql: ${TABLE}.EMAIL2 ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.GENDER ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: local_tax_rate {
    type: string
    sql: ${TABLE}.LOCAL_TAX_RATE ;;
  }

  dimension: middle_name {
    type: string
    sql: ${TABLE}.MIDDLE_NAME ;;
  }

  dimension: national_tax_rate {
    type: string
    sql: ${TABLE}.NATIONAL_TAX_RATE ;;
  }

  dimension: phone1 {
    type: string
    sql: ${TABLE}.PHONE1 ;;
  }

  dimension: phone2 {
    type: string
    sql: ${TABLE}.PHONE2 ;;
  }

  dimension: phone3 {
    type: string
    sql: ${TABLE}.PHONE3 ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.STATE ;;
  }

  dimension: tier {
    type: number
    sql: ${TABLE}.TIER ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.ZIPCODE ;;
  }

  dimension: source_expired {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED = 'true' ;;
  }

  dimension: replication_id {
    type: string
    sql: ${TABLE}._FIVETRAN_ID ;;
    hidden: yes
  }

  dimension: replication_synced {
    type: date_time
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      customer_id,
      last_name,
      first_name,
      account_name,
      middle_name,
      account.customer_name,
      account.count
    ]
  }
}
