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

LUALIB_API void init(lua_State *L)
{
    luaL_requiref(L,"lmprof",luaopen_lmprof,1);
    luaL_requiref(L,"lpeg",luaopen_lpeg,1);
    luaL_requiref(L,"cjson",luaopen_cjson_safe,1);
}