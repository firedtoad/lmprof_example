//
// Created by Administrator on 2022/08/29.
//

#include "lobject.h"
#include "lstate.h"
#include "ltable.h"
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>
#include <stdlib.h>
LUALIB_API int luaopen_lmprof(lua_State *L);
LUALIB_API int luaopen_lpeg(lua_State *L);
LUALIB_API int luaopen_cjson(lua_State *L);
LUALIB_API int luaopen_cjson_safe(lua_State *L);
LUALIB_API int luaopen_luatrace_c_hook(lua_State *L);

int LuaSlog(lua_State *L)
{
    const char *pFile  = NULL;
    const char *pFunc  = NULL;
    int qwLine         = -1;
    struct lua_Debug d = {};
    if (lua_getstack(L, 2, &d))
    {
        if (lua_getinfo(L, "Sln", &d))
        {
            pFile  = d.short_src;
            pFunc  = d.name ? d.name : "[main trunk]";
            qwLine = d.currentline;
        }
    }
    printf("[lua] [%s] [%s] [%d] %s ", pFile, pFunc, qwLine, lua_tostring(L, -1));
    return 0;
}

int NewTable(lua_State *L)
{
    int aSize = luaL_checkinteger(L, 1);
    int hSize = luaL_checkinteger(L, 2);
    lua_createtable(L, aSize, hSize);
    return 1;
}

int ResizeTable(lua_State *L)
{
    luaL_checktype(L, 1, LUA_TTABLE);
    int aSize = luaL_checkinteger(L, 2);
    int hSize = luaL_checkinteger(L, 3);
    Table *t  = (Table *)lua_topointer(L, 1);
    luaH_resize(L, t, aSize, hSize);
    return 0;
}

LUALIB_API void init(lua_State *L)
{
    luaL_requiref(L, "lmprof", luaopen_lmprof, 1);
    luaL_requiref(L, "lpeg", luaopen_lpeg, 1);
    luaL_requiref(L, "cjson", luaopen_cjson_safe, 1);
    luaL_requiref(L, "c_hook", luaopen_luatrace_c_hook, 1);
    lua_pushcfunction(L, LuaSlog);
    lua_setglobal(L, "LuaSlog");
    lua_pushcfunction(L, NewTable);
    lua_setglobal(L, "NewTable");
    lua_pushcfunction(L, ResizeTable);
    lua_setglobal(L, "ResizeTable");
}