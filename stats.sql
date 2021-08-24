@set

prompt ======================================
prompt ANALYZE - DATE - REGULAR TABLES
prompt ======================================

col owner format a20
prompt
select owner,'Tables'as "-" ,trunc(LAST_ANALYZED) as "LAST_ANAL",count(*) as Qtd
from dba_tables
where owner not in ('SYS','SYSTEM')
and owner like upper('%&1%')
group by owner,'Tables',trunc(LAST_ANALYZED)
order by owner, trunc(last_analyzed)
/
prompt
prompt ======================================
prompt ANALYZE - DATE - PARTITINED TABLES
prompt ======================================
prompt
select table_owner as "owner", 'Partitioned Tables' as "-" ,trunc(last_analyzed)  as "LAST_ANAL", count(*) as Qtd
from dba_tab_partitions
where table_owner not in ('SYS','SYSTEM')
and table_owner like upper('%&1%')
group by table_owner, 'Partitioned Tables',trunc(last_analyzed)
order by owner, trunc(last_analyzed)
/
prompt
prompt ======================================
prompt ANALYZE - DATE - REGULAR INDEXES
prompt ======================================
prompt
select owner, 'Regular Indexes'  as "-", trunc(last_analyzed) as "LAST_ANAL", count(*) as Qtd
from dba_indexes
where owner not in ('SYS','SYSTEM')
and owner like upper('%&1%')
group by  owner, 'Regular Indexes', trunc(last_analyzed)
order by owner, trunc(last_analyzed)
/
prompt
prompt ======================================
prompt ANALYZE - DATE - PARTITINED INDEXES
prompt ======================================
prompt
select index_owner as "owner", 'Partitioned Indexes' as "-" ,trunc(last_analyzed)  as "LAST_ANAL", count(*) as Qtd
from dba_ind_partitions
where index_owner not in ('SYS','SYSTEM')
and index_owner like upper('%&1%')
group by  index_owner, 'Partitioned Indexes',trunc(last_analyzed)
order by owner, trunc(last_analyzed)
/

undef 1