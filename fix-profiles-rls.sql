-- Fix: Allow users to INSERT their own profile row (needed for sign-up upsert)
-- Run this in Supabase Dashboard → SQL Editor

-- Drop old policies first to avoid conflicts, then recreate cleanly
DROP POLICY IF EXISTS "Users can insert own profile." ON public.profiles;
DROP POLICY IF EXISTS "Users can upsert own profile." ON public.profiles;

-- Allow authenticated users to insert their own profile row
CREATE POLICY "Users can insert own profile."
  ON public.profiles
  FOR INSERT
  WITH CHECK (auth.uid() = id);
