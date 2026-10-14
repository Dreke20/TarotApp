-- Tarot Application Supabase Schema Migration
-- Enables pgvector/uuid extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Profiles Table
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    display_name TEXT,
    avatar_url TEXT,
    zodiac_sign TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Profiles Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone" 
ON public.profiles FOR SELECT 
USING (true);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles FOR INSERT 
WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = id);

-- 2. Readings Table
CREATE TABLE IF NOT EXISTS public.readings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    question TEXT NOT NULL,
    spread_type TEXT NOT NULL,
    cards JSONB NOT NULL DEFAULT '[]'::jsonb,
    interpretation TEXT NOT NULL,
    summary TEXT,
    advice TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Readings Row Level Security (RLS)
ALTER TABLE public.readings ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own readings or public/anonymous readings
CREATE POLICY "Users can view their own readings or guest readings" 
ON public.readings FOR SELECT 
USING (
    auth.uid() IS NULL 
    OR auth.uid() = user_id 
    OR user_id IS NULL
);

-- Allow authenticated users and anon users to insert readings
CREATE POLICY "Anyone can insert readings" 
ON public.readings FOR INSERT 
WITH CHECK (true);

-- Allow users to delete their own readings
CREATE POLICY "Users can delete their own readings" 
ON public.readings FOR DELETE 
USING (auth.uid() = user_id);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_readings_user_id ON public.readings(user_id);
CREATE INDEX IF NOT EXISTS idx_readings_created_at ON public.readings(created_at DESC);
