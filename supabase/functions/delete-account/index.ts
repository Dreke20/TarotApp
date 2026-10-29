import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";
import { handleDeleteAccount, type DeleteDeps } from "./handler.ts";

function deps(): DeleteDeps {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !anonKey || !serviceKey) {
    throw new Error("missing_supabase_keys");
  }
  const admin = createClient(supabaseUrl, serviceKey);

  async function removePrefix(bucket: string, prefix: string): Promise<void> {
    const { data, error } = await admin.storage.from(bucket).list(prefix, { limit: 1000 });
    if (error || !data || data.length === 0) return;
    const files: string[] = [];
    for (const entry of data) {
      const path = `${prefix}/${entry.name}`;
      if (entry.id) {
        files.push(path);
      } else {
        await removePrefix(bucket, path);
      }
    }
    if (files.length > 0) {
      const { error: removeError } = await admin.storage.from(bucket).remove(files);
      if (removeError) throw new Error("storage_remove_failed");
    }
  }

  return {
    getUser: async (authHeader) => {
      const client = createClient(supabaseUrl, anonKey, {
        global: { headers: { Authorization: authHeader } },
      });
      const token = authHeader.replace(/^Bearer\s+/i, "");
      const { data, error } = await client.auth.getUser(token);
      if (error || !data.user) return null;
      return { id: data.user.id };
    },
    deleteRows: async (table, column, userId) => {
      const { error } = await admin.from(table).delete().eq(column, userId);
      if (error) throw new Error(`delete_${table}_failed`);
    },
    deleteStorage: async (userId) => {
      const { data: buckets, error } = await admin.storage.listBuckets();
      if (error) throw new Error("list_buckets_failed");
      for (const bucket of buckets ?? []) {
        await removePrefix(bucket.name, userId);
      }
    },
    revokeSessions: async (jwt) => {
      const { error } = await admin.auth.admin.signOut(jwt, "global");
      if (error) throw new Error("sign_out_failed");
    },
    deleteAuthUser: async (userId) => {
      const { error } = await admin.auth.admin.deleteUser(userId);
      if (error) throw new Error("delete_auth_user_failed");
    },
  };
}

serve(async (req: Request) => {
  try {
    return await handleDeleteAccount(req, deps());
  } catch (err) {
    const missing = err instanceof Error && err.message === "missing_supabase_keys";
    return new Response(JSON.stringify({
      error: missing
        ? "Server configuration error (missing keys)."
        : "Account deletion did not finish.",
    }), {
      status: missing ? 500 : 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
