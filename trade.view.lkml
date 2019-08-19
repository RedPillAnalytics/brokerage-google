view: trade {
  sql_table_name: (SELECT t.*,
                        CASE
                          WHEN sc.new_symbol is null then t.security_symbol
                          ELSE sc.new_symbol
                        END as symbol
           FROM  ORACLE_JUMP.TRADE t
       LEFT JOIN symbol_convert sc
              ON t.security_symbol = sc.old_symbol) ;;

  dimension: customer_account_id {
    type: number
    sql: ${TABLE}.CUSTOMER_ACCOUNT_ID ;;
    hidden: yes
  }

  dimension: executor_id {
    type: string
    sql: ${TABLE}.EXECUTOR_ID ;;
    hidden: yes
  }

  dimension: trade_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.TRADE_ID ;;
    hidden: yes
  }

  dimension_group:trade {
    type: time
    timeframes: [time, date, week, month, month_num, month_name,year, day_of_week_index, hour_of_day, minute5]
    sql: ${TABLE}.TRADE_DT ;;
  }

  dimension: status_type {
    hidden: yes
    type: string
    sql: ${TABLE}.STATUS_TYPE ;;
  }

  dimension: trade_type {
    hidden: yes
    type: string
    sql: ${TABLE}.TRADE_TYPE ;;
  }

  dimension: stock_symbol {
    hidden: yes
    type: string
    sql: ${TABLE}.SYMBOL ;;
  }

  dimension: transaction_type {
    type: string
    sql: CASE ${TABLE}.IS_CASH WHEN 1 then 'Cash' else 'Non-cash' end;;
  }

  measure: unique_customer_account_count {
    type: count_distinct
    sql: ${TABLE}.CUSTOMER_ACCOUNT_ID ;;
  }

  measure: unique_trade_count {
    type: count_distinct
    sql: ${TABLE}.TRADE_ID ;;
  }

  measure: total_trade_price {
    type: sum
    sql: ${TABLE}.TRADE_PRICE ;;
  }

  measure: average_trade_price {
    type: average
    sql: ${TABLE}.TRADE_PRICE ;;
  }

  measure:total_bid_price {
    type: sum
    sql: ${TABLE}.BID_PRICE ;;
  }

  measure:average_bid_price {
    type: average
    sql: ${TABLE}.BID_PRICE ;;
  }

  measure: total_commission {
    type: sum
    sql: ${TABLE}.COMMISSION ;;
  }

  measure: average_commission {
    type: average
    sql: ${TABLE}.COMMISSION ;;
  }

  measure: total_fees {
    type: sum
    sql: ${TABLE}.FEES ;;
  }

  measure: average_fees {
    type: average
    sql: ${TABLE}.FEES ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${TABLE}.QUANTITY ;;
  }

  measure: average_quantity {
    type: average
    sql: ${TABLE}.QUANTITY ;;
  }

  measure: total_tax {
    type: sum
    sql: ${TABLE}.TAX ;;
  }

  measure: average_tax {
    type: average
    sql: ${TABLE}.TAX ;;
  }

  measure: count {
    type: count
  }
}
