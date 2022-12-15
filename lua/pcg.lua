function create_pcg16()
    local g = {
        multiplier = 12829,
        mask = 0xffff,
        state = 0,
        inc = 0,
        seed = function(self, initstate, initseq)
            self.state = 0
            self.inc = self.mask & ((initseq << 1) | 1)
            self:step()
            self.state = self.mask & (self.state + initstate)
            self:step()
        end,
        step = function(self)
            self.state = self.mask & (self.state * self.multiplier + self.inc);
        end,
        lcg = function(self, state, delta, cur_mult, cur_plus)
            local acc_mult = 1
            local acc_plus = 0
            while delta > 0 do
                if (delta & 1) == 1 then
                    acc_mult = self.mask & (acc_mult * cur_mult)
                    acc_plus = self.mask & ((acc_plus * cur_mult) + cur_plus)
                end
                cur_plus = self.mask & ((cur_mult + 1) * cur_plus)
                cur_mult = self.mask & (cur_mult * cur_mult)
                delta = self.mask & (delta // 2)
            end
            return self.mask & ((acc_mult * state) + acc_plus)
        end,
        advance = function(self, delta)
            self.state = self.mask & self:lcg(self.state, delta, self.multiplier, self.inc)
        end,
        random = function(self)
            local state = self.state
            self:step()
            local x = self.mask & (((state >> ((state >> 13) + 3)) ~ state) * 62169);
            return (x >> 11) ~ x
        end
    }
	g:seed(0,0)
    return g
end


function create_pcg32()
    local g = {
        multiplier = 747796405,
        mask = 0xffffffff,
        state = 0,
        inc = 0,
        seed = function(self, initstate, initseq)
            self.state = 0
            self.inc = self.mask & ((initseq << 1) | 1)
            self:step()
            self.state = self.mask & (self.state + initstate)
            self:step()
        end,
        step = function(self)
            self.state = self.mask & (self.state * self.multiplier + self.inc);
        end,
        lcg = function(self, state, delta, cur_mult, cur_plus)
            local acc_mult = 1
            local acc_plus = 0
            while delta > 0 do
                if (delta & 1) == 1 then
                    acc_mult = self.mask & (acc_mult * cur_mult)
                    acc_plus = self.mask & ((acc_plus * cur_mult) + cur_plus)
                end
                cur_plus = self.mask & ((cur_mult + 1) * cur_plus)
                cur_mult = self.mask & (cur_mult * cur_mult)
                delta = self.mask & (delta // 2)
            end
            return self.mask & ((acc_mult * state) + acc_plus)
        end,
        advance = function(self, delta)
            self.state = self.mask & self:lcg(self.state, delta, self.multiplier, self.inc)
        end,
        random = function(self)
            local state = self.state
            self:step()
            local x = self.mask & (((state >> ((state >> 28) + 4)) ~ state) * 277803737);
            return (x >> 22) ~ x
        end
    }
	g:seed(0,0)
    return g
end

function create_pcg64()
    local g = {
        multiplier = 6364136223846793005,
        mask = 0xffffffffffffffff,
        state = 0,
        inc = 0,
        seed = function(self, initstate, initseq)
            self.state = 0
            self.inc = self.mask & ((initseq << 1) | 1)
            self:step()
            self.state = self.mask & (self.state + initstate)
            self:step()
        end,
        step = function(self)
            self.state = self.mask & (self.state * self.multiplier + self.inc);
        end,
        lcg = function(self, state, delta, cur_mult, cur_plus)
            local acc_mult = 1
            local acc_plus = 0
            while delta > 0 do
                if (delta & 1) == 1 then
                    acc_mult = self.mask & (acc_mult * cur_mult)
                    acc_plus = self.mask & ((acc_plus * cur_mult) + cur_plus)
                end
                cur_plus = self.mask & ((cur_mult + 1) * cur_plus)
                cur_mult = self.mask & (cur_mult * cur_mult)
                delta = self.mask & (delta // 2)
            end
            return self.mask & ((acc_mult * state) + acc_plus)
        end,
        advance = function(self, delta)
            self.state = self.mask & self:lcg(self.state, delta, self.multiplier, self.inc)
        end,
        random = function(self)
            local state = self.state
            self:step()
            local x = self.mask & (((state >> ((state >> 59) + 5)) ~ state) * 12605985483714917081);
            return (x >> 43) ~ x
        end
    }
	g:seed(0,0)
    return g
end
local g=create_pcg16()
local tb={}
for i=1,655388 do 
	local x=g:random()
	tb[x]=(tb[x] or 0)+1
	if  tb[x]>1 then
		print(i,x)
		break
	end
end

g=create_pcg32()
g:seed(0,0)
g:advance(65535)
print(g:random())
print(g:random())
print(g:random())
print(g:random())
print(g:random())
print(g:random())
print(g:random())