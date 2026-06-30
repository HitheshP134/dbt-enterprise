"""SQLFluff jinja templater stubs for dbt_utils package macros."""


def generate_surrogate_key(field_list):
    return "dummy_surrogate_key"


def star(from_=None, relation_alias=None, except_=None, prefix="", suffix="", quote_identifiers=False):
    return "*"


def get_column_values(table, column, order_by=None, default=None):
    return []


def pivot(column, values, alias=True, agg="sum", cmp="=", prefix="", suffix="", then_value=1, else_value=0, quote_identifiers=False):
    return "null"


def date_trunc(datepart, date):
    return date


def datediff(datepart, startdate, enddate):
    return 0


def dateadd(datepart, interval, from_date_or_timestamp):
    return from_date_or_timestamp


def safe_divide(numerator, denominator):
    return 0.0


def generate_date_spine(datepart, start_date, end_date):
    return []
