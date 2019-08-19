view: security {
  sql_table_name: ORACLE_JUMP.SYMBOLS ;;

  dimension: company_name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: security_exchange {
    type: string
    sql: ${TABLE}.EXCHANGE ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.INDUSTRY ;;
  }

  dimension: ipo_year {
    type: number
    sql: ${TABLE}.IPO_YEAR ;;
  }

  dimension: sector {
    type: string
    sql: ${TABLE}.SECTOR ;;
  }

  dimension: summary_quote {
    type: string
    sql: ${TABLE}.SUMMARY_QUOTE ;;
  }

  dimension: symbol {
    type: string
    sql: ${TABLE}.SYMBOL ;;
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

  measure: total_last_sale {
    type: sum
    sql: ${TABLE}.LAST_SALE ;;
  }

  measure: average_last_sale {
    type: average
    sql: ${TABLE}.LAST_SALE ;;
  }

  measure: total_market_cap {
    type: sum
    sql: ${TABLE}.MARKET_CAP ;;
  }

  measure: average_market_cap {
    type: average
    sql: ${TABLE}.MARKET_CAP ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}
