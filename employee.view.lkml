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
