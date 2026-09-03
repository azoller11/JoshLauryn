-- Generic booking/events dashboard schema for Supabase (Postgres).
-- Run this once in your Supabase project's SQL Editor:
-- left sidebar > SQL Editor > New query > paste this in > Run.

-- 1. Table holding each booking/event row on the dashboard.
create table if not exists events (
  id text primary key,
  client_name text,
  phone text,
  email text,
  event_date date,
  start_time time,
  end_time time,
  duration_hours double precision,
  status text,
  service_type text,
  price double precision,
  deposit_status text,
  deposit_amount double precision,
  location text,
  staff text,
  notes text,
  needs_review boolean default false,
  created_at timestamptz default now()
);

-- 2. Row Level Security: permissive policies so anyone with the project's
--    URL and anon key can read and write. Fine for an internal, link-shared
--    dashboard with no login step; tighten with Supabase Auth if you later
--    want per-user access control.
alter table events enable row level security;

create policy "Public can read events"
  on events for select
  using (true);

create policy "Public can insert events"
  on events for insert
  with check (true);

create policy "Public can update events"
  on events for update
  using (true)
  with check (true);

create policy "Public can delete events"
  on events for delete
  using (true);

-- 3. Realtime: pushes every insert/update/delete to all connected clients,
--    so a browser-based dashboard can stay in sync live across viewers.
alter publication supabase_realtime add table events;
