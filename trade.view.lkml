view: trade {
  sql_table_name: (SELECT t.*,
                        CASE
                          WHEN sc.new_symbol is null then t.security_symbol
                          ELSE sc.new_symbol
                        END as symbol
           FROM  brokerage.trade t
       LEFT JOIN brokerage.symbol_convert sc
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

    dimension_group: trade {
      type: time
      timeframes: [
        raw,
        time,
        minute5,
        hour_of_day,
        date,
        day_of_week_index,
        week,
        day_of_week,
        month,
        month_num,
        month_name,
        day_of_month,
        quarter,
        day_of_year,
        year
      ]
      sql: CAST(${TABLE}.TRADE_DT AS TIMESTAMP) ;;
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
      label: "Total Trade Price"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.TRADE_PRICE ;;
    }

    measure: average_trade_price {
      type: average
      label: "Average Trade Price"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.TRADE_PRICE ;;
    }

    measure:total_bid_price {
      type: sum
      label: "Total Bid Price"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.BID_PRICE ;;
    }

    measure:average_bid_price {
      type: average
      label: "Average Bid Price"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.BID_PRICE ;;
    }

    measure: total_commission {
      type: sum
      label: "Total Commission"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.COMMISSION ;;
    }

    measure: average_commission {
      type: average
      label: "Average Commission"
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.COMMISSION ;;
    }

    measure: total_fees {
      type: sum
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.FEES ;;
    }

    measure: average_fees {
      type: average
      value_format: "$#.00;($#.00)"
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
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.TAX ;;
    }

    measure: average_tax {
      type: average
      value_format: "$#.00;($#.00)"
      sql: ${TABLE}.TAX ;;
    }

    measure: count {
      type: count
    }
  }
