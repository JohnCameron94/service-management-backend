import { Request, Response, NextFunction } from "express";


const logger = (req: Request, res: Response, next: NextFunction) => {
    console.log(`${req.method} ${req.path}
    Headers: ${JSON.stringify(req.headers, null, 2)}
    Body: ${JSON.stringify(req.body, null, 2)}
    `);
    next();
}

export default logger;