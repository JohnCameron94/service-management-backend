import { Request, Response, NextFunction } from "express";
import { BaseError } from "../errors/BaseError";


export const errorHandler = (err: Error, req: Request, res: Response, next: NextFunction) => {
    // Handled errors
    if(err instanceof  BaseError) {
            const { statusCode, errors, logging } = err;
            if(logging) {
                console.error(
                    JSON.stringify({
                        code: err.statusCode,
                        errors: err.errors,
                        stack: err.stack,
                    }, null, 2)
                );
            }
        res.status(statusCode).send({ errors });
    }     

    // Unhandled errors
    console.error(JSON.stringify(err, null, 2));
    res.status(500).send({ errors: [{ message: "Something went wrong" }] });
};