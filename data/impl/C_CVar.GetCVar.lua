local env, cvars, var = ...
return cvars[var] or env.C_CVar.GetCVarDefault(var)
