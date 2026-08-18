-- Cobox Studio — esquema completo de Supabase (un solo tablero compartido)
-- Correr esto UNA sola vez en un proyecto de Supabase nuevo (SQL Editor -> New query -> Run).
-- No hace falta activar nada en Authentication — no hay login de ningún tipo.

create table if not exists boards (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table boards enable row level security;

-- Solo existe una fila ('cobox-equipo'). Las políticas solo permiten leer/escribir
-- esa fila exacta — nadie puede listar ni tocar ninguna otra.
create policy "shared board read"
on boards for select
to anon
using (id = 'cobox-equipo');

create policy "shared board update"
on boards for update
to anon
using (id = 'cobox-equipo')
with check (id = 'cobox-equipo');

create policy "shared board insert"
on boards for insert
to anon
with check (id = 'cobox-equipo');

alter publication supabase_realtime add table boards;
