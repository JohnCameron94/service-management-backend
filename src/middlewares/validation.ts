import { Request, Response, NextFunction } from 'express';
import Joi from 'joi';
import BadRequestError from '../errors/BadRequestError';

const CRUD = {
    CREATE: 0,
    UPDATE: 1,
    DELETE: 2,
    READ: 3
}


const userSchema = Joi.object({
    idToken: Joi.string().optional(),
    authenticationUser: Joi.string().optional(),
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net']}})
}).options({allowUnknown: true});



export const validCreateUser = (req: Request, res: Response, next: NextFunction): void => {
    console.log(`Validating Request => ${JSON.stringify(req.body, null, 2)}`)
    const { error } = userSchema.validate(req.body);
    if(error){
        // Throw new Error for Error Middleware to catch.
        throw new BadRequestError({
            code: 400, 
            logging: true,
            context: {
                op: CRUD.CREATE,
                message: error.message
            }
        });
    } else next();
}


