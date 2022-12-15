{% macro athena__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database) %}

    {% set sql %}
        select distinct
            table_schema as "table_schema",
            table_name as "table_name",
            {{ dbt_utils.get_table_types_sql() }}
        from {{ database }}.information_schema.tables
        where lower(table_schema) like lower('{{ schema_pattern }}')
            and lower(table_name) like lower('{{ table_pattern }}')
            and lower(table_name) not like lower('{{ exclude }}')
        order by
            1, 2
    {% endset %}

    {{ return(sql) }}

{% endmacro %}
