-- Dungeon Run Schedule: run this once in the Supabase SQL Editor.

create table if not exists players (
  id    text primary key,
  name  text not null,
  tz    text not null,
  cls   text not null default '',
  slots jsonb not null default '[]'::jsonb
);

create table if not exists runs (
  id      text primary key,
  name    text not null,
  "start" timestamptz not null,
  note    text not null default '',
  "by"    text,
  members jsonb not null default '[]'::jsonb,
  classes jsonb not null default '{}'::jsonb
);

-- No logins: anyone who has the site link can read and edit the schedule.
alter table players enable row level security;
alter table runs enable row level security;

drop policy if exists "team access" on players;
drop policy if exists "team access" on runs;
create policy "team access" on players for all to anon using (true) with check (true);
create policy "team access" on runs for all to anon using (true) with check (true);

grant select, insert, update, delete on players, runs to anon;
