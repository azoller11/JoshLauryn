-- Twist Booking Board — Supabase schema
-- Run this once in your Supabase project's SQL Editor (left sidebar > SQL Editor > New query > Run).

create table if not exists public.events (
  id text primary key,
  name text,
  phone text,
  email text,
  date date,
  "start" text,
  "end" text,
  "durationHrs" numeric,
  status text,
  "boothType" text,
  prints text,
  price numeric,
  "depositStatus" text,
  "depositAmount" numeric,
  location text,
  staff text,
  equipment text,
  "setupTime" text,
  "teardownTime" text,
  "travelDistance" text,
  notes text,
  "needsReview" boolean not null default false,
  "addedToCalendar" boolean not null default false,
  "bookedBy" text,
  created_at timestamptz not null default now()
);

alter table public.events enable row level security;

-- Open access, no login (matches the app's current "anyone with the link" behavior).
-- Scoped to this table only, unlike the old embedded GitHub token which had repo-wide write access.
create policy "public read" on public.events for select using (true);
create policy "public insert" on public.events for insert with check (true);
create policy "public update" on public.events for update using (true) with check (true);
create policy "public delete" on public.events for delete using (true);
