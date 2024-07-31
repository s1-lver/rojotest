local ErrorService = {}

--// LOCAL METHODS

function Warn(err: string)
    warn("\n!WARNING!\n",err,"\n\nTraceback:",debug.traceback("",6))
end

--// SERVICE METHODS

function ErrorService.TryWarn(func: (any) -> any): boolean
    local success = xpcall(func,Warn)
    return success
end

function ErrorService.Try(func: (any) -> any): boolean
    local success = pcall(func)
    return success
end

return ErrorService