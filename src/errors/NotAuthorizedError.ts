import { BaseError } from "./BaseError";

export default class NotAuthorizedError extends BaseError {
    private static readonly _statusCode = 400;
    private readonly _code: number;
    private readonly _logging: boolean;
    private readonly _context: { [key: string]: any };

    constructor(params?: {code?: number, message?: string, logging?: boolean, context?: { [key: string]: any }}) {
        const { code, message, logging } = params || {};
    
        super("Not Authorized");
        this._code = code || NotAuthorizedError._statusCode;
        this._logging = logging || false;
        this._context = params?.context || {};

        // Only because we are extending a built in class
        Object.setPrototypeOf(this, NotAuthorizedError.prototype);
    }

    get errors() {
        return [{ message: "Not Authorized", context: this._context }];
    }

    get statusCode() {
        return this._code;
    }

    get logging() {
        return this._logging;
    }
}