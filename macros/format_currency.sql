{% macro format_currency(column_name, currency='$') %}
    '{{ currency }}' || ' ' || round({{ column_name }}::numeric, 2)::text
{% endmacro %}