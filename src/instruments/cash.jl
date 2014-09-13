####
# Types
####

type Cash <: Instrument
    amount::Real
    rate::Real
    tradedate::TimeType
    startdate::TimeType
    enddate::TimeType
    index::CashIndex
end

####
# Methods
####

currency(instr::Cash) = currency(instr.index)

function Cash(currency::Currency, rate::Real, tradedate::TimeType = EVAL_DATE,
    amount::Real = 1e6)
    index = CashIndex(currency)
    startdate = tradedate
    enddate = adjust(tradedate + Day(1), index.bdc, index.calendar)
    Cash(amount, rate, tradedate, startdate, enddate, index)
end

function price(instr::Cash, date::TimeType)
    date == tradedate || error("Trade and pricing dates are not the same.")
    return instr.amount
end
