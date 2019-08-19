view: status {
  sql_table_name: ORACLE_JUMP.STATUS_TYPE ;;

  dimension: status_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.ST_ID ;;
  }

  dimension: status_name {
    type: string
    sql: ${TABLE}.ST_NAME ;;
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
    drill_fields: [status_name]
  }
}
