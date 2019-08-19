view: trade_type {
  sql_table_name: brokerage.trade_type ;;

  dimension: market_category {
    type: string
    sql: CASE ${TABLE}.IS_MRKT WHEN 1 then 'Market' else 'Non-market' end;;
  }

  dimension: trade_category {
    type: string
    sql: CASE ${TABLE}.IS_SELL WHEN 1 then 'Sell' else 'Buy' end;;
  }

  dimension: trade_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.TRADE_ID ;;
  }

  dimension: trade_type {
    type: string
    sql: ${TABLE}.TRADE_NAME ;;
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
    drill_fields: [trade_type, trade.trade_id]
  }
}
