//
// Created by Administrator on 2022/08/29.
//
#include <stdlib.h>
#include <lua.h>
#include <lauxlib.h>
LUALIB_API int luaopen_lmprof (lua_State *L);
LUALIB_API int luaopen_lpeg (lua_State *L);
LUALIB_API int luaopen_cjson (lua_State *L);
LUALIB_API int luaopen_cjson_safe (lua_State *L);

void LuaSlog(lua_State *L)
{
    const char* pFile = NULL;
    const char* pFunc = NULL;
    int qwLine = -1;
    struct lua_Debug d={};
    if (lua_getstack(L, 2, &d))
    {
        if (lua_getinfo(L, "Sln", &d))
        {
            pFile = d.short_src;
            pFunc = d.name ? d.name : "[main trunk]";
            qwLine = d.currentline;
        }
    }
    printf("[lua] [%s] [%s] [%d] %s ",pFile,pFunc,qwLine, lua_tostring(L,-1));
}

LUALIB_API void init(lua_State *L)
{
    luaL_requiref(L,"lmprof",luaopen_lmprof,1);
    luaL_requiref(L,"lpeg",luaopen_lpeg,1);
    luaL_requiref(L,"cjson",luaopen_cjson_safe,1);
    lua_pushcfunction(L,LuaSlog);
    lua_setglobal(L,"LuaSlog");
}