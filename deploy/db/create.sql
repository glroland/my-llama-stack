create user llamastack with password 'llamastack';
ALTER USER llamastack WITH SUPERUSER;

create database llamastack_sql with owner llamastack;
create database llamastack_kv with owner llamastack;

