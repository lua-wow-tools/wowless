local env, cvars, var = ...
return tostring(cvars[var] or env.C_CVar.GetCVarDefault(var)) == '1'
