-- No Supabase: abre SQL Editor e executa este ficheiro.
create table if not exists public.app_state (
  id integer primary key check (id = 1),
  payload jsonb not null default '{"groups":[],"children":[],"history":[]}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.app_state enable row level security;
drop policy if exists "signed users can read transport state" on public.app_state;
drop policy if exists "signed users can insert transport state" on public.app_state;
drop policy if exists "signed users can update transport state" on public.app_state;
create policy "signed users can read transport state" on public.app_state for select to authenticated using (true);
create policy "signed users can insert transport state" on public.app_state for insert to authenticated with check (true);
create policy "signed users can update transport state" on public.app_state for update to authenticated using (true) with check (true);
insert into public.app_state (id, payload) values (1, '{"groups":[],"children":[],"history":[]}'::jsonb) on conflict (id) do nothing;
